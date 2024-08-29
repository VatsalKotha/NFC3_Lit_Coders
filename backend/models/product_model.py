class Product:
    def __init__(self, product_id, product_name, available_quantity, base_cost_phh, base_cost_aay, base_cost_bpl):
        self.product_id = product_id
        self.product_name = product_name
        self.available_quantity = available_quantity
        self.base_cost_phh = base_cost_phh 
        self.base_cost_aay = base_cost_aay  
        self.base_cost_bpl = base_cost_bpl  

    def to_dict(self):
        return {
            "product_id": self.product_id,
            "product_name": self.product_name,
            "available_quantity": self.available_quantity,
            "base_cost_phh": self.base_cost_phh,
            "base_cost_aay": self.base_cost_aay,
            "base_cost_bpl": self.base_cost_bpl,
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            product_id=data.get("product_id"),
            product_name=data.get("product_name"),
            available_quantity=data.get("available_quantity"),
            base_cost_phh=data.get("base_cost_phh"),
            base_cost_aay=data.get("base_cost_aay"),
            base_cost_bpl=data.get("base_cost_bpl"),
        )
