import React, { useState, useEffect } from 'react';
import axios from 'axios';
import ProductCard from '../Components/Card/InventoryCard'; // Adjust path if needed
import './Inventory.css'; // Ensure this file exists for custom styling

// import React, { useState, useEffect } from 'react';

const Inventory = () => {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const accessToken = import.meta.env.VITE_ACCESS_TOKEN;

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch('https://nfc3-lit-coders-i8r5.onrender.com/fps/get_global_products', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({}), // Add an empty object if the API expects a body
        });
  
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
  
        const data = await response.json();
        setProducts(data.products);
        setLoading(false);
      } catch (error) {
        setLoading(false);
        setError(`Error: ${error.message}`);
      }
    };
  
    fetchProducts();
  }, [accessToken]);
  
  return (
    <div className="inventory-container">
      <header className="inventory-header">
        <h1>Inventory</h1>
      </header>
      <div className="product-cards-container">
        {loading && <p>Loading...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {products.map((product) => (
          <ProductCard
            key={product.product_id}
            image={product.product_image}
            name={product.product_name}
            size={product.product_size}
            price={product.base_cost_aay}
          />
        ))}
      </div>
    </div>
  );
};

export default Inventory;
