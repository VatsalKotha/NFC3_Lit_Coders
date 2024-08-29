class GlobalProduct:
    def __init__(self, product_id, product_name, product_image):
        self.product_id = product_id
        self.product_name = product_name
        self.product_image = product_image  

    def to_dict(self):
        return {
            "product_id": self.product_id,
            "product_name": self.product_name,
            "product_image": self.product_image,
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            product_id=data.get("product_id"),
            product_name=data.get("product_name"),
            product_image=data.get("product_image"),
        )
