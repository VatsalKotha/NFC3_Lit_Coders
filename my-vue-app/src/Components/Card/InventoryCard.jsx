import React, { useState } from 'react';
import ModifyProductModal from '../ModifyProductModal/ModifyProductModal';

const ProductCard = ({ product_id, image, name, size, price, available_quantity, base_cost_phh, base_cost_aay, base_cost_bpl }) => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleModifyClick = () => {
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  return (
    <div className="bg-white shadow-lg rounded-lg overflow-hidden" style={{ width: '300px' }}>
      <img src={image} alt={name} className="w-full h-40 object-cover" />
      <div className="p-4">
        <h3 className="text-lg font-semibold">{name}</h3>
        <p className="text-gray-500">{size}</p>
        
        {/* Conditionally render available quantity */}
        {available_quantity > 0 && (
          <p className="text-gray-900 font-semibold mt-1">Available Quantity: {available_quantity}</p>
        )}
        
        {/* Conditionally render base cost for PHH */}
        {base_cost_phh > 0 && (
          <p className="text-gray-900 font-semibold mt-1">PHH Price: ${base_cost_phh.toFixed(2)}</p>
        )}

        {/* Conditionally render base cost for AAY */}
        {base_cost_aay > 0 && (
          <p className="text-gray-900 font-semibold mt-1">AAY Price: ${base_cost_aay.toFixed(2)}</p>
        )}

        {/* Conditionally render base cost for BPL */}
        {base_cost_bpl > 0 && (
          <p className="text-gray-900 font-semibold mt-1">BPL Price: ${base_cost_bpl.toFixed(2)}</p>
        )}

        <button
          className="mt-4 bg-custom-purple-500 text-white py-2 px-4 rounded bg-custom-purple hover:bg-blue-600"
          onClick={handleModifyClick}
        >
          Modify
        </button>
      </div>

      {isModalOpen && (
        <ModifyProductModal
          product={{
            product_id,
            available_quantity,
            base_cost_phh,
            base_cost_aay,
            base_cost_bpl,
          }}
          onClose={handleCloseModal}
        />
      )}
    </div>
  );
};

export default ProductCard;
