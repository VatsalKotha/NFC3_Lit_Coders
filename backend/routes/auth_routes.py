import random
from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from settings.auth_utils import get_user_by_ration_card_id, get_store_by_fps_id
import smtplib
from settings.config import Config
from settings.db import db

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/send_otp', methods=['POST'])
def sendOTP():
    try:
        data = request.get_json()
        ration_card_id = data.get('ration_card_id')
        user = get_user_by_ration_card_id(ration_card_id)
        if not user:
            return jsonify({"msg": "No such user!"}), 401

        server = smtplib.SMTP(Config.SMTP_SERVER, Config.SMTP_PORT)
        server.starttls()
        server.login(Config.SMTP_USERNAME, Config.SMTP_PASSWORD)

        otp = random.randint(100000, 999999)

        db.otp.insert_one({"ration_card_id": ration_card_id, "otp": str(otp) })

        subject = "Your OTP for RationGo!"
        message = f"Subject: {subject}\n\nYour OTP for RationGo! is: {otp}. Team LitCoders - NFC 3.0"

        server.sendmail(Config.SMTP_USERNAME, user.email, message)
        server.quit()

        return jsonify({"msg": "OTP sent successfully"}), 200
    except Exception as e:
        return jsonify({"msg": str(e)}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        ration_card_id = data.get('ration_card_id')
        otp = data.get('otp')

        if not db.otp.find_one_and_delete({"ration_card_id": ration_card_id, "otp": otp }):
            return jsonify({"msg": "Invalid OTP!"}), 401

        user = get_user_by_ration_card_id(ration_card_id)
        if not user:
            return jsonify({"msg": "No such user!"}), 401

        access_token = create_access_token(identity={"ration_card_id": ration_card_id})
        return jsonify(access_token=access_token), 200
    except Exception as e:
        return jsonify({"msg": str(e)}), 500
    
@auth_bp.route('/send_otp_fps', methods=['POST'])
def sendOTPFPS():
    try:
        data = request.get_json()
        fps_id = data.get('fps_id')
        fps_store = get_store_by_fps_id(fps_id)
        if not fps_store:
            return jsonify({"msg": "No such store!"}), 401

        server = smtplib.SMTP(Config.SMTP_SERVER, Config.SMTP_PORT)
        server.starttls()
        server.login(Config.SMTP_USERNAME, Config.SMTP_PASSWORD)

        otp = random.randint(100000, 999999)

        db.otp.insert_one({"fps_id": fps_id, "otp": str(otp) })

        subject = "Your OTP for RationGo!"
        message = f"Subject: {subject}\n\nYour OTP for RationGo! is: {otp}. Team LitCoders - NFC 3.0"

        server.sendmail(Config.SMTP_USERNAME, fps_store.email, message)
        server.quit()

        return jsonify({"msg": "OTP sent successfully"}), 200
    except Exception as e:
        return jsonify({"msg": str(e)}), 500

@auth_bp.route('/login_fps', methods=['POST'])
def login_fps():
    try:
        data = request.get_json()
        fps_id = data.get('fps_id')
        otp = data.get('otp')

        if not db.otp.find_one_and_delete({"fps_id": fps_id, "otp": otp }):
            return jsonify({"msg": "Invalid OTP!"}), 401

        fps_store = get_store_by_fps_id(fps_id)
        if not fps_store:
            return jsonify({"msg": "No such store!"}), 401

        access_token = create_access_token(identity={"fps_id": fps_id})
        return jsonify(access_token=access_token), 200
    except Exception as e:
        return jsonify({"msg": str(e)}), 500
