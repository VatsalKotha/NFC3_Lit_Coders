// src/components/ModifyProductModal/ModifyProductModal.jsx
import React, { useState } from 'react';
import axios from 'axios';

const ModifyProductModal = ({ product, onClose }) => {
  const [availableQuantity, setAvailableQuantity] = useState(product.available_quantity || '');
  const [baseCostPHH, setBaseCostPHH] = useState(product.base_cost_phh || '');
  const [baseCostAAY, setBaseCostAAY] = useState(product.base_cost_aay || '');
  const [baseCostBPL, setBaseCostBPL] = useState(product.base_cost_bpl || '');

  const handleSubmit = async () => {
    const payload = {
      product_id: product.product_id,
      available_quantity: parseInt(availableQuantity),
      base_cost_phh: parseFloat(baseCostPHH),
      base_cost_aay: parseFloat(baseCostAAY),
      base_cost_bpl: parseFloat(baseCostBPL),
    };

    try {
      const response = await axios.post('https://nfc3-lit-coders-i8r5.onrender.com/fps/add_or_update_product', payload, {
        headers: {
          'Authorization': `Bearer ${import.meta.env.VITE_ACCESS_TOKEN}`,
          'Content-Type': 'application/json',
        },
      });

      if (response.status === 200) {
        alert('Product updated successfully!');
        onClose();
      } else {
        alert(`Failed to update product: ${response.statusText}`);
      }
    } catch (error) {
      alert(`Error updating product: ${error.message}`);
    }
  };

  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <h2>Modify Product</h2>
        <div className="modal-body">
          <label>
            Available Quantity:
            <input
              type="number"
              value={availableQuantity}
              onChange={(e) => setAvailableQuantity(e.target.value)}
            />
          </label>
          <label>
            Base Cost (PHH):
            <input
              type="number"
              step="0.01"
              value={baseCostPHH}
              onChange={(e) => setBaseCostPHH(e.target.value)}
            />
          </label>
          <label>
            Base Cost (AAY):
            <input
              type="number"
              step="0.01"
              value={baseCostAAY}
              onChange={(e) => setBaseCostAAY(e.target.value)}
            />
          </label>
          <label>
            Base Cost (BPL):
            <input
              type="number"
              step="0.01"
              value={baseCostBPL}
              onChange={(e) => setBaseCostBPL(e.target.value)}
            />
          </label>
        </div>
        <div className="modal-footer">
          <button onClick={handleSubmit}>Save Changes</button>
          <button onClick={onClose}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default ModifyProductModal;
