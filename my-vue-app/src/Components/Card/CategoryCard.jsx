import React from "react";

const Card = ({ title, description, icon, onClick }) => {
  return (
    <div className="bg-gradient-to-br from-custom-purple  via-custom-purple  to-custom-purple-accent 500 text-white p-6 rounded-lg shadow-lg flex items-center space-x-4" onClick={onClick}>
      <div className="text-4xl">{icon}</div>
      <div>
        <h2 className="text-xl font-bold">{title}</h2>
        <p>{description}</p>
      </div>
    </div>
  );
};

export default Card;
