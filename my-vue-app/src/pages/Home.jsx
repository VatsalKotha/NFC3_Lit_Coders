// src/pages/Home.jsx
import React from 'react';
import Navbar from '../Components/Navbar/Navbar';
import CategoryCard from '../Components/Card/CategoryCard';
import ProductCard from '../Components/Card/ProductCard'; // Import ProductCard
import grains from '../assets/grains.jpg';
import pulses from '../assets/pulses.jpg';
import rice from '../assets/rice.jpg';
import bannerImage from '../assets/banner.jpg'; // Import the banner image
import './Home.css'; // Import the CSS file for styling

const Home = () => {
  const categories = [
    { image: grains, title: 'Grains', description: 'Explore' },
    { image: pulses, title: 'Pulses', description: 'Explore' },
    { image: rice, title: 'Rice', description: 'Explore' },
  ];

  const products = [
    { image: grains, name: 'Grains', price: 100 },
    { image: pulses, name: 'Pulses', price: 45 },
    { image: rice, name: 'Rice', price: 39 },
  ];

  return (
    <div className="home-container">
      <Navbar />
      <div className="banner">
        <img src={bannerImage} alt="Banner" className="banner-image" />
      </div>
      <div className="section">
        <h1 className="section-heading">Categories</h1>
        <div className="category-cards-container">
          {categories.map((category, index) => (
            <CategoryCard
              key={index}
              image={category.image}
              title={category.title}
              description={category.description}
            />
          ))}
        </div>
      </div>
      <div className="section">
        <h1 className="section-heading">Products</h1>
        <div className="product-cards-container">
          {products.map((product, index) => (
            <ProductCard
              key={index}
              image={product.image}
              name={product.name}
              price={product.price}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

export default Home;
