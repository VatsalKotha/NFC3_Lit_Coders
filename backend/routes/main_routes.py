from flask import Blueprint, request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from settings.db import db
from settings.auth_utils import get_store_by_fps_id, get_user_by_ration_card_id

main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def index():
    return {"message": "Welcome to the Lit-Coders Backend!"}

@main_bp.route('/verify_token',methods=['POST'])
@jwt_required()
def verify_token():
    current_user = get_jwt_identity()
    ration_card_id = current_user["ration_card_id"]
    user = get_user_by_ration_card_id(ration_card_id)
    return jsonify({"user": user.to_dict()}), 200

@main_bp.route('/get_store_products', methods=['POST'])
@jwt_required()
def get_store_products():
    try:
        current_user = get_jwt_identity()
        ration_card_id = current_user["ration_card_id"]
        user = get_user_by_ration_card_id(ration_card_id)
        
        fps_id = user.fps_code
        fps_store = get_store_by_fps_id(fps_id)
        
        detailed_products = []

        for fps_product in fps_store.products:
            global_product = db.products.find_one({"product_id": fps_product.product_id})
            
            if global_product:
                price = 0

                if user.class_of_ration == "PHH":
                    price = fps_product.base_cost_phh
                elif user.class_of_ration == "AAY":
                    price = fps_product.base_cost_aay
                else:
                    price = fps_product.base_cost_bpl

                cart_quantity = 0

                    
                detailed_product = {
                    "product_id": fps_product.product_id,
                    "product_name": global_product["product_name"],
                    "product_image": global_product["product_image"],
                    "product_size": global_product["product_size"],
                    "product_category": global_product["product_category"],
                    "available_quantity": fps_product.available_quantity,
                    "price": price,
                    "cart": cart_quantity
                }
                detailed_products.append(detailed_product)

        return jsonify({"products": detailed_products}), 200

    except Exception as e:
        return jsonify({"msg": str(e)}), 500

