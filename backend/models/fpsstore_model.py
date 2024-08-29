from datetime import datetime

from models.order_model import Order
from models.product_model import Product

class FPSStore:
    def __init__(self, fps_id, store_name,email, address, next_available_date, products=None, orders=None):
        self.fps_id = fps_id
        self.store_name = store_name
        self.address = address
        self.email = email
        self.next_available_date = next_available_date
        self.products = products if products is not None else []
        self.orders = orders if orders is not None else []

    def to_dict(self):
        return {
            "fps_id": self.fps_id,
            "store_name": self.store_name,
            "email": self.email,
            "address": self.address,
            "next_available_date": self.next_available_date.strftime('%Y-%m-%d'),
            "products": [product.to_dict() for product in self.products],
            "orders": [order.to_dict() for order in self.orders],
        }

    @classmethod
    def from_dict(cls, data):
        products = [Product.from_dict(prod) for prod in data.get("products", [])]
        orders = [Order.from_dict(ord) for ord in data.get("orders", [])]
        return cls(
            fps_id=data.get("fps_id"),
            store_name=data.get("store_name"),
            email=data.get("email"),
            address=data.get("address"),
            next_available_date=datetime.strptime(data.get("next_available_date"), '%Y-%m-%d'),
            products=products,
            orders=orders,
        )
