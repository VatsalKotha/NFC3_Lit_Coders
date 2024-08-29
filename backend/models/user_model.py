from typing import List, Dict, Any
from dataclasses import dataclass, field
from datetime import date

@dataclass
class CartItem:
    prod_id: str
    prod_name: str
    prod_quantity: float
    base_cost: float
    prod_cost: float

    def to_dict(self) -> Dict[str, Any]:
        return {
            "prod_id": self.prod_id,
            "prod_name": self.prod_name,
            "prod_quantity": self.prod_quantity,
            "base_cost": self.base_cost,
            "prod_cost": self.prod_cost
        }

    @staticmethod
    def from_dict(data: Dict[str, Any]) -> 'CartItem':
        return CartItem(
            prod_id=data["prod_id"],
            prod_name=data["prod_name"],
            prod_quantity=data["prod_quantity"],
            base_cost=data["base_cost"],
            prod_cost=data["prod_cost"]
        )


@dataclass
class User:
    ration_card_id: str
    name: str
    fps_code: str
    fps_name: str
    members_list: List[str]
    total_monthly_quantity: float
    current_quantity_consumed: float
    has_LPG: bool
    date_of_issue: date
    address: str
    class_of_ration: str
    contact_number: str
    email: str
    cart: List[CartItem] = field(default_factory=list)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "ration_card_id": self.ration_card_id,
            "name": self.name,
            "fps_code": self.fps_code,
            "fps_name": self.fps_name,
            "members_list": self.members_list,
            "total_monthly_quantity": self.total_monthly_quantity,
            "current_quantity_consumed": self.current_quantity_consumed,
            "has_LPG": self.has_LPG,
            "date_of_issue": self.date_of_issue.isoformat(),
            "address": self.address,
            "class_of_ration": self.class_of_ration,
            "contact_number": self.contact_number,
            "email": self.email,
            "cart": [item.to_dict() for item in self.cart]
        }

    @staticmethod
    def from_dict(data: Dict[str, Any]) -> 'User':
        return User(
            ration_card_id=data["ration_card_id"],
            name=data["name"],
            fps_code=data["fps_code"],
            fps_name=data["fps_name"],
            members_list=data["members_list"],
            total_monthly_quantity=data["total_monthly_quantity"],
            current_quantity_consumed=data["current_quantity_consumed"],
            has_LPG=data["has_LPG"],
            date_of_issue=date.fromisoformat(data["date_of_issue"]),
            address=data["address"],
            class_of_ration=data["class_of_ration"],
            contact_number=data["contact_number"],
            email=data["email"],
            cart=[CartItem.from_dict(item) for item in data.get("cart", [])]
        )
