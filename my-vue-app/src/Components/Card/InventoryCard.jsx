// src/components/ProductCard/ProductCard.jsx
import React from 'react';

const ProductCard = ({ image, name, size, price }) => {
  return (
    <div className="bg-white shadow-lg rounded-lg overflow-hidden">
      <img src={image} alt={name} className="w-full h-40 object-cover" />
      <div className="p-4">
        <h3 className="text-lg font-semibold">{name}</h3>
        <p className="text-gray-500">{size}</p>
        <p className="text-gray-900 font-semibold mt-1">${price.toFixed(2)}</p>
        <button className="mt-4 bg-custom-purple 500 text-white py-2 px-4 rounded hover:bg-blue-600">
          Add to Cart
        </button>
      </div>
    </div>
  );
};

export default ProductCard;
