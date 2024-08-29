// src/components/Footer/Footer.jsx
import React from 'react';
import { FaFacebookF, FaTwitter, FaInstagram, FaLinkedinIn } from 'react-icons/fa'; // Import social media icons

const Footer = () => {
  return (
    <footer className="bg-gray-800 text-white py-8">
      <div className="container mx-auto px-4">
        <div className="flex flex-wrap justify-between mb-8">
          {/* About Section */}
          <div className="w-full md:w-1/4 mb-4 md:mb-0">
            <h3 className="text-lg font-semibold mb-4">About Us</h3>
            <p className="text-gray-400 text-sm">
              We are committed to providing the best delivery service with a focus on quality and customer satisfaction.
            </p>
          </div>

          {/* Quick Links Section */}
          <div className="w-full md:w-1/4 mb-4 md:mb-0">
            <h3 className="text-lg font-semibold mb-4">Quick Links</h3>
            <ul className="space-y-2">
              <li><a href="#" className="hover:text-gray-400">Home</a></li>
              <li><a href="#" className="hover:text-gray-400">Menu</a></li>
              <li><a href="#" className="hover:text-gray-400">Contact</a></li>
              <li><a href="#" className="hover:text-gray-400">Privacy Policy</a></li>
            </ul>
          </div>

          {/* Contact Section */}
          <div className="w-full md:w-1/4 mb-4 md:mb-0">
            <h3 className="text-lg font-semibold mb-4">Contact Us</h3>
            <p className="text-gray-400 text-sm">
              123 Food Street, City, Country<br />
              Phone: +123 456 7890<br />
              Email: support@yourcompany.com
            </p>
          </div>

          {/* Follow Us Section */}
          <div className="w-full md:w-1/4 mb-4 md:mb-0">
            <h3 className="text-lg font-semibold mb-4">Follow Us</h3>
            <div className="flex space-x-4">
              <a href="#" className="text-gray-400 hover:text-white">
                <FaFacebookF size={20} />
              </a>
              <a href="#" className="text-gray-400 hover:text-white">
                <FaTwitter size={20} />
              </a>
              <a href="#" className="text-gray-400 hover:text-white">
                <FaInstagram size={20} />
              </a>
              <a href="#" className="text-gray-400 hover:text-white">
                <FaLinkedinIn size={20} />
              </a>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-700 pt-4 text-center text-gray-400 text-sm">
          <p>&copy; 2024 RationGo. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
