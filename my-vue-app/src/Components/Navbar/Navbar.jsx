// Navbar.jsx
import React, { useState } from 'react';
import './Navbar.css';

const Navbar = () => {
  const [option, setOption] = useState('delivery'); // State to track selected option (delivery or pickup)
  const [location, setLocation] = useState('Mumbai'); // State for location
  const [address, setAddress] = useState(''); // State for address or pincode
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false); // State to manage mobile menu visibility

  const handleOptionChange = (newOption) => {
    setOption(newOption);
  };

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  return (
    <nav className="navbar">
      <div className="navbar-options">
        <button
          className={`toggle-btn ${option === 'delivery' ? 'active' : ''}`}
          onClick={() => handleOptionChange('delivery')}
        >
          Delivery
        </button>
        <button
          className={`toggle-btn ${option === 'pickup' ? 'active' : ''}`}
          onClick={() => handleOptionChange('pickup')}
        >
          Pickup
        </button>
      </div>

      {option === 'delivery' ? (
        <div className="navbar-delivery">
          <div className="delivery-input">
            <input
              type="text"
              placeholder="Enter city"
              value={location}
              onChange={(e) => setLocation(e.target.value)}
              className="location-input"
            />
          </div>
          <div className="address-input">
            <input
              type="text"
              placeholder="Enter address or pincode"
              value={address}
              onChange={(e) => setAddress(e.target.value)}
              className="address-input-field"
            />
          </div>
        </div>
      ) : (
        <div className="navbar-pickup">
          <span className="store-address">Store Address: 123 Main Street, Mumbai</span>
        </div>
      )}

      <button className="mobile-menu-toggle" onClick={toggleMobileMenu}>
        ☰
      </button>

      <div className={`navbar-links ${isMobileMenuOpen ? 'active' : ''}`}>
        <ul>
          <li><a href="#">Home</a></li>
          <li><a href="#">Categories</a></li>
          <li><a href="#">Products</a></li>
          <li><a href="#">Help</a></li>
        </ul>
      </div>

      <div className="navbar-actions">
        <button className="login-btn">Login</button>
      </div>
    </nav>
  );
};

export default Navbar;
