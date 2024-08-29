from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from models.globalproduct_model import GlobalProduct
from models.product_model import Product
from settings.auth_utils import get_user_by_ration_card_id, get_store_by_fps_id
import smtplib
from settings.config import Config
from settings.db import db

fps_bp = Blueprint('fps', __name__)

@fps_bp.route('/add_or_update_product', methods=['POST'])
@jwt_required()
def add_or_update_product():
    try:
        current_user = get_jwt_identity()  
        fps_id = current_user["fps_id"]    

        fps_store = get_store_by_fps_id(fps_id)
        if not fps_store:
            return jsonify({"msg": "FPS store not found"}), 404

        data = request.get_json()         
        new_product = Product.from_dict(data)  

        # Remove the product if it already exists
        db.fps.update_one(
            {"fps_id": fps_id},
            {"$pull": {"products": {"product_id": new_product.product_id}}}
        )

        # Add the new or updated product to the products list
        db.fps.update_one(
            {"fps_id": fps_id},
            {"$push": {"products": new_product.to_dict()}}
        )

        return jsonify({"msg": "Product added/updated successfully!", "product": new_product.to_dict()}), 200

    except Exception as e:
        return jsonify({"msg": str(e)}), 500

    
@fps_bp.route('/get_global_products', methods=['POST'])
def get_global_products():
    try:
        products = db.products.find()
        return jsonify({"products": [GlobalProduct.from_dict(prod).to_dict() for prod in products]}), 200
    except Exception as e:
        return jsonify({"msg": str(e)}), 500
