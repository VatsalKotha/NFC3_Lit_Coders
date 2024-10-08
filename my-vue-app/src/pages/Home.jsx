// import React, { useState } from 'react';
// import Sidebar from '../Components/Navbar/Navbar';
// import Card from '../Components/Card/CategoryCard';
// import CardContent from '../Components/CardContent';
// import { FaClipboardCheck, FaCheck, FaTruck, FaBoxOpen, FaCogs, FaTshirt, FaShippingFast, FaTimesCircle } from 'react-icons/fa';

// const Home = () => {
//   const [activeTab, setActiveTab] = useState("Dashboard"); 

//   const handleTabClick = (title) => {
//     setActiveTab(title); 
//   };

//   return (
//     <div className="flex">
//       <Sidebar onTabClick={handleTabClick} activeTab={activeTab} />
//       <div className="flex-1 p-10 bg-gray-100">
//         <h1 className="text-2xl font-bold mb-6">Welcome to RationGo!</h1>
//         {activeTab !== "Dashboard" ? (
//           <CardContent cardTitle={activeTab} />  
//         ) : (
//           <div className="grid grid-cols-3 gap-6">
//             <Card title="All Orders" description="Manage all of your orders" icon={<FaClipboardCheck />} onClick={() => handleTabClick("All Orders")} />
//             <Card title="Orders Placed" description="Manage all currently placed orders" icon={<FaCheck />} onClick={() => handleTabClick("Orders Placed")} />
//             <Card title="Manage / Inventory" description="Manage all your SKU and Inventory" icon={<FaTruck />} onClick={() => handleTabClick("Manage / Inventory")} />
//             <Card title="Orders Received" description="Manage all currently picked up and received orders" icon={<FaBoxOpen />} onClick={() => handleTabClick("Orders Received")} />
//             <Card title="Orders Processing" description="Manage all currently processing orders" icon={<FaCogs />} onClick={() => handleTabClick("Orders Processing")} />
//             <Card title="Orders Processed" description="Manage all currently processed orders" icon={<FaTshirt />} onClick={() => handleTabClick("Orders Processed")} />
//             <Card title="Orders Out For Delivery" description="Manage all currently out for delivery orders" icon={<FaShippingFast />} onClick={() => handleTabClick("Orders Out For Delivery")} />
//             <Card title="Orders Delivered" description="Manage all delivered orders" icon={<FaCheck />} onClick={() => handleTabClick("Orders Delivered")} />
//             <Card title="Orders Cancelled" description="Manage all cancelled orders" icon={<FaTimesCircle />} onClick={() => handleTabClick("Orders Cancelled")} />
//           </div>
//         )}
//       </div>
//     </div>
//   );
// };

// export default Home;
// src/Pages/Home.jsx
import React, { useState } from 'react';
import Sidebar from '../Components/Navbar/Navbar';
import Card from '../Components/Card/CategoryCard';
import CardContent from '../Components/CardContent';
import Inventory from '../pages/Inventory';
import Chat from '../pages/Chat';
import { FaClipboardCheck, FaCheck, FaTruck, FaBoxOpen, FaCogs, FaTshirt, FaShippingFast, FaTimesCircle, FaCommentDots } from 'react-icons/fa';

const Home = () => {
  const [activeTab, setActiveTab] = useState("Dashboard");

  const handleTabClick = (title) => {
    setActiveTab(title);
  };

  return (
    <div className="flex">
      <Sidebar onTabClick={handleTabClick} activeTab={activeTab} />
      <div className="flex-1 p-10 bg-gray-100">
        <h1 className="text-2xl font-bold mb-6">FPS Management Portal</h1>
        {activeTab === "Dashboard" && (
          <div className="grid grid-cols-3 gap-6">
            <Card title="Manage / Inventory" description="Manage all your SKU and Inventory" icon={<FaTruck />} onClick={() => handleTabClick("Manage / Inventory")} />
            <Card title="All Orders" description="Manage all of your orders" icon={<FaClipboardCheck />} onClick={() => handleTabClick("All Orders")} />
            <Card title="Orders Received" description="Manage all currently picked up and received orders" icon={<FaBoxOpen />} onClick={() => handleTabClick("Orders Received")} />
            <Card title="Orders Processing" description="Manage all currently processing orders" icon={<FaCogs />} onClick={() => handleTabClick("Orders Processing")} />
            <Card title="Orders Processed" description="Manage all currently processed orders" icon={<FaTshirt />} onClick={() => handleTabClick("Orders Processed")} />
            <Card title="Orders Out For Delivery" description="Manage all currently out for delivery orders" icon={<FaShippingFast />} onClick={() => handleTabClick("Orders Out For Delivery")} />
            <Card title="Orders Delivered" description="Manage all delivered orders" icon={<FaCheck />} onClick={() => handleTabClick("Orders Delivered")} />
            <Card title="Orders Cancelled" description="Manage all cancelled orders" icon={<FaTimesCircle />} onClick={() => handleTabClick("Orders Cancelled")} />
            <Card title="Chat Support" description="Get help from customer support" icon={<FaCommentDots />} onClick={() => handleTabClick("Chat Support")} />
          </div>
        )}
        {activeTab === "Manage / Inventory" && <Inventory />}
        {activeTab === "Chat Support" && <Chat />}
        {activeTab !== "Dashboard" && activeTab !== "Manage / Inventory" && activeTab !== "Chat Support" && (
          <CardContent cardTitle={activeTab} />
        )}
      </div>
    </div>
  );
};

export default Home;
