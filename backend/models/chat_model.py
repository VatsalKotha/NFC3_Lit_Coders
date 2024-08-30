from datetime import datetime

class ChatMessage:
    def __init__(self, ration_card_id, fps_id, message, is_sender, timestamp=None):
        self.ration_card_id = ration_card_id
        self.fps_id = fps_id
        self.message = message
        self.is_sender = is_sender
        self.timestamp = timestamp or datetime.utcnow()

    def to_dict(self):
        return {
            "ration_card_id": self.ration_card_id,
            "fps_id": self.fps_id,
            "message": self.message,
            "is_sender": self.is_sender,
            "timestamp": self.timestamp.strftime('%Y-%m-%d %H:%M:%S')
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            ration_card_id=data.get("ration_card_id"),
            fps_id=data.get("fps_id"),
            message=data.get("message"),
            is_sender=data.get("is_sender"),
            timestamp=datetime.strptime(data.get("timestamp"), '%Y-%m-%d %H:%M:%S')
        )
