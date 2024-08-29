from datetime import datetime

class ProductOrder:
    def __init__(self, product_id, product_name, quantity, actual_price):
        self.product_id = product_id
        self.product_name = product_name
        self.quantity = quantity
        self.actual_price = actual_price  

    def to_dict(self):
        return {
            "product_id": self.product_id,
            "product_name": self.product_name,
            "quantity": self.quantity,
            "actual_price": self.actual_price,
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            product_id=data.get("product_id"),
            product_name=data.get("product_name"),
            quantity=data.get("quantity"),
            actual_price=data.get("actual_price"),
        )
        
class Order:
    def __init__(self, order_id, fps_id, ration_card_id, order_type, expected_fulfilment_date,
                 payment_method, payment_id, order_status, products=None):
        self.order_id = order_id
        self.fps_id = fps_id
        self.ration_card_id = ration_card_id
        self.order_type = order_type  
        self.expected_fulfilment_date = expected_fulfilment_date
        self.payment_method = payment_method
        self.payment_id = payment_id
        self.order_status = order_status
        self.products = products if products is not None else []

    def to_dict(self):
        return {
            "order_id": self.order_id,
            "fps_id": self.fps_id,
            "ration_card_id": self.ration_card_id,
            "order_type": self.order_type,
            "expected_fulfilment_date": self.expected_fulfilment_date.strftime('%Y-%m-%d'),
            "payment_method": self.payment_method,
            "payment_id": self.payment_id,
            "order_status": self.order_status,
            "products": [product.to_dict() for product in self.products],  
        }

    @classmethod
    def from_dict(cls, data):
        products = [ProductOrder.from_dict(prod) for prod in data.get("products", [])]
        return cls(
            order_id=data.get("order_id"),
            fps_id=data.get("fps_id"),
            ration_card_id=data.get("ration_card_id"),
            order_type=data.get("order_type"),
            expected_fulfilment_date=datetime.strptime(data.get("expected_fulfilment_date"), '%Y-%m-%d'),
            payment_method=data.get("payment_method"),
            payment_id=data.get("payment_id"),
            order_status=data.get("order_status"),
            products=products,
        )
