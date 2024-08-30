import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaClipboardList, FaTruck, FaCheck, FaBoxOpen, FaCogs, FaTshirt, FaShippingFast, FaClipboardCheck, FaTimesCircle, FaSignOutAlt } from 'react-icons/fa';

const Sidebar = ({ onTabClick, activeTab }) => {
  const navigate = useNavigate();

  const handleTabClick = (title) => {
    if (title === 'Logout') {
      navigate('/'); // Navigate to root URL
    } else {
      onTabClick(title);
    }
  };

  const tabs = [
    { title: "Dashboard", icon: <FaClipboardList /> },
    { title: "Manage / Inventory", icon: <FaTruck /> },
    { title: "All Orders", icon: <FaClipboardCheck /> },
    // { title: "Orders Placed", icon: <FaCheck /> },
    
    { title: "Orders Received", icon: <FaBoxOpen /> },
    { title: "Orders Processing", icon: <FaCogs /> },
    { title: "Orders Processed", icon: <FaTshirt /> },
    { title: "Orders Out For Delivery", icon: <FaShippingFast /> },
    { title: "Orders Delivered", icon: <FaClipboardCheck /> },
    { title: "Orders Cancelled", icon: <FaTimesCircle /> },
    { title: "Logout", icon: <FaSignOutAlt /> },
  ];

  return (
    <div className="w-64 h-screen bg-gradient-to-b from-custom-purple via-custom-purple to-custom-purple-accent text-white">
      <div className="flex  flex-col  p-4 text-xl font-semibold border-b border-white">
        <span className="mr-2">RationGo!</span>
        <span className="text-sm font-normal">Management System</span>
     
      </div>
      
      <ul className="mt-5">
        {tabs.map((tab) => (
          <li
            key={tab.title}
            onClick={() => handleTabClick(tab.title)}
            className={`flex items-center p-4 cursor-pointer ${
              activeTab === tab.title ? 'bg-custom-purple-accent' : 'hover:bg-custom-purple'
            }`}
          >
            {tab.icon}
            <span className="ml-3">{tab.title}</span>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Sidebar;
