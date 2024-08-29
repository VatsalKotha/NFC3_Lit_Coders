import React from 'react';
import Sidebar from '../Components/Navbar/Navbar';
import Card from '../Components/Card/CategoryCard';
import { FaClipboardCheck, FaCheck, FaTruck, FaBoxOpen, FaCogs, FaTshirt , FaShippingFast, FaTimesCircle } from 'react-icons/fa';

const Home = () => {
  return (
    <div className="flex">
      <Sidebar />
      <div className="flex-1 p-10 bg-gray-100">
        <h1 className="text-2xl font-bold mb-6">Welcome to RationGo</h1>
        <div className="grid grid-cols-3 gap-6">
          <Card title="All Orders" description="Manage all of your orders" icon={<FaClipboardCheck />} />
          <Card title="Orders Placed" description="Manage all currently placed orders" icon={<FaCheck />} />
          <Card title="Orders Out For Pickup" description="Manage all currently out for pickup orders" icon={<FaTruck />} />
          <Card title="Orders Received" description="Manage all currently picked up and received orders" icon={<FaBoxOpen />} />
          <Card title="Orders Processing" description="Manage all currently processing orders" icon={<FaCogs />} />
          <Card title="Orders Processed" description="Manage all currently processed orders" icon={<FaTshirt  />} />
          <Card title="Orders Out For Delivery" description="Manage all currently out for delivery orders" icon={<FaShippingFast />} />
          <Card title="Orders Delivered" description="Manage all delivered orders" icon={<FaCheck />} />
          <Card title="Orders Cancelled" description="Manage all cancelled orders" icon={<FaTimesCircle />} />
        </div>
      </div>
    </div>
  );
};

export default Home;
