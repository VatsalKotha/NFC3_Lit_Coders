import React from 'react';
import { FaClipboardList, FaTruck, FaCheck, FaBoxOpen, FaCogs, FaTshirt, FaShippingFast, FaClipboardCheck, FaTimesCircle } from 'react-icons/fa';

const Sidebar = ({ onTabClick, activeTab }) => {
  const tabs = [
    { title: "Dashboard", icon: <FaClipboardList /> },
    { title: "All Orders", icon: <FaClipboardCheck /> },
    { title: "Orders Placed", icon: <FaCheck /> },
    { title: "Orders Out For Pickup", icon: <FaTruck /> },
    { title: "Orders Received", icon: <FaBoxOpen /> },
    { title: "Orders Processing", icon: <FaCogs /> },
    { title: "Orders Processed", icon: <FaTshirt /> },
    { title: "Orders Out For Delivery", icon: <FaShippingFast /> },
    { title: "Orders Delivered", icon: <FaClipboardCheck /> },
    { title: "Orders Cancelled", icon: <FaTimesCircle /> },
  ];

  return (
    <div className="w-64 h-screen bg-[#613CB1] text-white">
      <div className="flex items-center justify-center p-4 text-xl font-bold border-b border-blue-500">
        <span className="mr-2">RationGo</span>
      </div>
      <ul className="mt-5">
        {tabs.map((tab) => (
          <li
            key={tab.title}
            onClick={() => onTabClick(tab.title)} 
            className={`flex items-center p-4 cursor-pointer ${
              activeTab === tab.title ? 'bg-orange-500' : 'hover:bg-orange-500'
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
