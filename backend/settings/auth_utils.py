from models.user_model import User
from settings.db import db

def get_user_by_ration_card_id(ration_card_id: str):
    user_data =  db.users.find_one({"ration_card_id": ration_card_id})
    if user_data:
        return User.from_dict(user_data)
    return None

