from flask import Blueprint, request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from models.order_model import Order, ProductOrder
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

                # Initialize cart_quantity to 0
                cart_quantity = 0
                cart = user.to_dict()["cart"]

                for x in cart:
                    if x["product_id"] == fps_product.product_id:
                        cart_quantity = x["quantity"]
                        break
                    
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

        return jsonify({"products": detailed_products,"user":user.to_dict(),"fps_store":fps_store.to_dict()}), 200

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
            updated_user = get_user_by_ration_card_id(ration_card_id)
            store = get_store_by_fps_id(user.fps_code)
            return jsonify({"msg": "Product removed from cart successfully!","user":updated_user.to_dict(),"store":store.to_dict()}), 200

        if existing_cart_item:
            user.cart.remove(existing_cart_item)

        product_order = ProductOrder(
            product_id=fps_product.product_id,
            product_name=fps_product.product_name,
            quantity=quantity,
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

        updated_user = get_user_by_ration_card_id(ration_card_id)
        store = get_store_by_fps_id(user.fps_code)
        return jsonify({"msg": "Product added to cart successfully!","user":updated_user.to_dict(),"store":store.to_dict()}), 200

    except Exception as e:
        return jsonify({"msg": str(e)}), 500
    


@main_bp.route('/add_order', methods=['POST'])
@jwt_required()
def add_order():
    try:
        current_user = get_jwt_identity()
        ration_card_id = current_user["ration_card_id"]
        
        user = get_user_by_ration_card_id(ration_card_id)
        fps_store = get_store_by_fps_id(user.fps_code)

        total_cart_quantity = sum([item.quantity for item in user.cart])
        total_capacity = user.total_monthly_quantity
        
        if user.current_quantity_consumed == 0 and total_cart_quantity > total_capacity:
            return jsonify({"msg": "Total cart quantity exceeds your monthly capacity"}), 400
        
        order_id = "ORDER" + str(db.orders.count_documents({}) + 1).zfill(4)
        order_type = request.json.get("order_type")
        payment_method = request.json.get("payment_method")
        payment_id = request.json.get("payment_id")
        order_status = "Pending"
        expected_fulfilment_date = fps_store.next_available_date

        #calculate total amount
        total_amount = 0
        for item in user.cart:
            total_amount += item.actual_price * item.quantity
        
        new_order = Order(
            order_id=order_id,
            fps_id=user.fps_code,
            ration_card_id=ration_card_id,
            order_type=order_type,
            expected_fulfilment_date=expected_fulfilment_date,
            payment_method=payment_method,
            payment_id=payment_id,
            order_status=order_status,
            products=user.cart,
            total_amount=total_amount
        )
        
        user.current_quantity_consumed += total_cart_quantity

        db.fps.find_one_and_update(
            {"fps_id": user.fps_code},
            {"$push": {"orders": new_order.to_dict()}}
        )
        
        db.users.find_one_and_update(
            {"ration_card_id": ration_card_id},
            {"$set": {
                "current_quantity_consumed": user.current_quantity_consumed,
                "cart": []
            }}
        )

        return jsonify({"msg": "Order placed successfully!"}), 200

    except Exception as e:
        return jsonify({"msg": str(e)}), 500
