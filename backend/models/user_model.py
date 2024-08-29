from datetime import datetime
from typing import List

from models.order_model import ProductOrder

class User:
    def __init__(self, ration_card_id, name, fps_code, fps_name, members_list, total_monthly_quantity,
                 current_quantity_consumed, has_lpg, date_of_issue, address, class_of_ration,
                 email, phone, cart=None):
        self.ration_card_id = ration_card_id
        self.name = name
        self.fps_code = fps_code
        self.fps_name = fps_name
        self.members_list = members_list
        self.total_monthly_quantity = total_monthly_quantity
        self.current_quantity_consumed = current_quantity_consumed
        self.has_lpg = has_lpg
        self.date_of_issue = date_of_issue
        self.address = address
        self.class_of_ration = class_of_ration
        self.email = email
        self.phone = phone
        self.cart = cart if cart is not None else []

    def to_dict(self):
        return {
            "ration_card_id": self.ration_card_id,
            "name": self.name,
            "fps_code": self.fps_code,
            "fps_name": self.fps_name,
            "members_list": self.members_list,
            "total_monthly_quantity": self.total_monthly_quantity,
            "current_quantity_consumed": self.current_quantity_consumed,
            "has_lpg": self.has_lpg,
            "date_of_issue": self.date_of_issue.strftime('%Y-%m-%d'),
            "address": self.address,
            "class_of_ration": self.class_of_ration,
            "email": self.email,
            "contact_number": self.phone,
            "cart": [product_order.to_dict() for product_order in self.cart],  # Convert ProductOrder to dict
        }

    @classmethod
    def from_dict(cls, data):
        cart = [ProductOrder.from_dict(prod) for prod in data.get("cart", [])]
        return cls(
            ration_card_id=data.get("ration_card_id"),
            name=data.get("name"),
            fps_code=data.get("fps_code"),
            fps_name=data.get("fps_name"),
            members_list=data.get("members_list", []),
            total_monthly_quantity=data.get("total_monthly_quantity"),
            current_quantity_consumed=data.get("current_quantity_consumed", 0),
            has_lpg= bool(data.get("has_lpg")),
            date_of_issue=datetime.strptime(data.get("date_of_issue"), '%Y-%m-%d'),
            address=data.get("address"),
            class_of_ration=data.get("class_of_ration"),
            email=data.get("email"),
            phone= str(data.get("contact_number"))   ,
            cart=cart,
        )
