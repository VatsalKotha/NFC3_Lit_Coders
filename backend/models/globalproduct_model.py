class GlobalProduct:
    def __init__(self, product_id, product_name, product_image, product_size, product_category):
        self.product_id = product_id
        self.product_name = product_name
        self.product_image = product_image  
        self.product_size = product_size
        self.product_category = product_category

    def to_dict(self):
        return {
            "product_id": self.product_id,
            "product_name": self.product_name,
            "product_image": self.product_image,
            "product_size": self.product_size,
            "product_category": self.product_category,
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            product_id=data.get("product_id"),
            product_name=data.get("product_name"),
            product_image=data.get("product_image"),
            product_size=data.get("product_size"),
            product_category=data.get("product_category"),
        )
