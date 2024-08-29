// CategoryCard.jsx
import React from 'react';
import './CategoryCard.css';

const CategoryCard = ({ image, title, description }) => {
  return (
    <div className="category-card">
      <img src={image} alt={title} className="category-card-image" />
      <div className="category-card-content">
        <h3 className="category-card-title">{title}</h3>
        <p className="category-card-description">{description}</p>
      </div>
    </div>
  );
};

export default CategoryCard;
