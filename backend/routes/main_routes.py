from flask import Blueprint, request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from models.order_model import ProductOrder
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
                if fps_product.product_id in user.cart:
                    cart_quantity = user.cart[fps_product.product_id].quantity

                    
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

@main_bp.route('/add_to_cart', methods=['POST'])
@jwt_required()
def add_to_cart():
    try:
        current_user = get_jwt_identity()
        ration_card_id = current_user["ration_card_id"]
        
        user = get_user_by_ration_card_id(ration_card_id)
        data = request.get_json()

        product_id = data.get('product_id')
        quantity = data.get('quantity')
        actual_price = data.get('actual_price')

        fps_store = get_store_by_fps_id(user.fps_code)
        fps_product = next((prod for prod in fps_store.products if prod.product_id == product_id), None)

        if not fps_product:
            return jsonify({"msg": "Product not found in FPS store"}), 404

        if quantity > fps_product.available_quantity:
            return jsonify({"msg": "Requested quantity exceeds available stock"}), 400

        existing_cart_item = next((prod for prod in user.cart if prod.product_id == product_id), None)

        if quantity == 0:
            if existing_cart_item:
                user.cart.remove(existing_cart_item)
                db.users.find_one_and_update(
                    {"ration_card_id": ration_card_id},
                    {"$set": {"cart": [prod.to_dict() for prod in user.cart]}}
                )
            return jsonify({"msg": "Product removed from cart"}), 200

        if existing_cart_item:
            user.cart.remove(existing_cart_item)

        product_order = ProductOrder(
            product_id=fps_product.product_id,
            product_name=fps_product.product_name,
            available_quantity=quantity,
            actual_price=actual_price
        )

        fps_product.available_quantity -= quantity

        user.cart.append(product_order)

        db.users.find_one_and_update(
            {"ration_card_id": ration_card_id},
            {"$set": {"cart": [prod.to_dict() for prod in user.cart]}}
        )

        db.fps.find_one_and_update(
            {"fps_id": fps_store.fps_id, "products.product_id": product_id},
            {"$set": {"products.$.available_quantity": fps_product.available_quantity}}
        )

        return jsonify({"msg": "Product added to cart successfully!"}), 200

    except Exception as e:
        return jsonify({"msg": str(e)}), 500