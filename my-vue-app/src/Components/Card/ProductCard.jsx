// src/components/ProductCard.jsx
import React from 'react';

const ProductCard = ({ image, name, price }) => {
  return (
    <div className="max-w-sm mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
      <img className="w-full h-48 object-cover" src={image} alt={name} />
      <div className="p-4">
        <h2 className="text-xl font-semibold mb-2">{name}</h2>
        <p className="text-gray-600 mb-4">₹{price.toFixed(2)}</p>
        <button className="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400">
          Add to Cart
        </button>
      </div>
    </div>
  );
};

export default ProductCard;
