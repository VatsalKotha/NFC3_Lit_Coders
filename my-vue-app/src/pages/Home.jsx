// src/pages/Home.jsx
import React from 'react';
import Navbar from '../Components/Navbar/Navbar';
import CategoryCard from '../Components/Card/CategoryCard';
import grains from '../assets/grains.jpg';
import pulses from '../assets/pulses.jpg';
import rice from '../assets/rice.jpg';


const Home = () => {
  const categories = [
    { image: grains, title: 'Grains', description: 'Explore' },
    { image: pulses, title: 'Pulses', description: 'Explore' },
    { image: rice, title: 'Rice', description: 'Explore' },
  ];

  return (
    <div>
      <Navbar />
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
  );
};

export default Home;
