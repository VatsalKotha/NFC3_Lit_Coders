import React from 'react';
import { FaClipboardList, FaTruck, FaCheck, FaBoxOpen, FaCogs, FaTshirt, FaShippingFast, FaClipboardCheck, FaTimesCircle, FaSignOutAlt } from 'react-icons/fa';

const Sidebar = () => {
  return (
    <div className="w-64 h-screen bg-custom-purple 600 text-white">
      <div className="flex items-center justify-center p-4 text-xl font-bold border-b border-blue-500">
        <span className="mr-2">RationGo</span>
      </div>
      <ul className="mt-5">
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaClipboardList className="mr-3" />
          <span>Dashboard</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaClipboardCheck className="mr-3" />
          <span>All Orders</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaCheck className="mr-3" />
          <span>Orders Placed</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaTruck className="mr-3" />
          <span>Orders Out For Pickup</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaBoxOpen className="mr-3" />
          <span>Orders Received</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaCogs className="mr-3" />
          <span>Orders Processing</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaTshirt className="mr-3" />
          <span>Orders Processed</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaShippingFast className="mr-3" />
          <span>Orders Out For Delivery</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaClipboardCheck className="mr-3" />
          <span>Orders Delivered</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaTimesCircle className="mr-3" />
          <span>Orders Cancelled</span>
        </li>
        <li className="flex items-center p-4 hover:bg-orange-500 cursor-pointer">
          <FaSignOutAlt className="mr-3" />
          <span>Logout</span>
        </li>
      </ul>
    </div>
  );
};

export default Sidebar;
