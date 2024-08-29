from models.user_model import User
from models.fpsstore_model import FPSStore
from settings.db import db

def get_user_by_ration_card_id(ration_card_id: str):
    user_data =  db.users.find_one({"ration_card_id": ration_card_id})
    if user_data:
        return User.from_dict(user_data)
    return None

def get_store_by_fps_id(fps_id: str):
    store_data =  db.fps.find_one({"fps_id": fps_id})
    if store_data:
        return FPSStore.from_dict(store_data)
    return None

