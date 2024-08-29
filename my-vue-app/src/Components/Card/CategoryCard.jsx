import React from 'react';

const Card = ({ title, description, icon }) => {
  return (
    <div className="bg-custom-purple 500 text-white p-6 rounded-lg shadow-lg flex items-center space-x-4">
      <div className="text-4xl">
        {icon}
      </div>
      <div>
        <h2 className="text-xl font-bold">{title}</h2>
        <p>{description}</p>
      </div>
    </div>
  );
};

export default Card;
