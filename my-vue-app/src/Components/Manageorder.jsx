import React, { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom"; // Using useNavigate for navigation

const ManageOrder = () => {
  const navigate = useNavigate(); // To navigate back to the dashboard
  const [status, setStatus] = useState("Processing");
  const [estimatedDelivery, setEstimatedDelivery] = useState("2024-09-05");
  const [deliveryPerson, setDeliveryPerson] = useState("John Doe");
  const location = useLocation();
  const { fpsId } = location.state || {};  
  console.log(fpsId)

  const handleStatusChange = (e) => setStatus(e.target.value);
  const handleEstimatedDeliveryChange = (e) =>
    setEstimatedDelivery(e.target.value);
  const handleDeliveryPersonChange = (e) => setDeliveryPerson(e.target.value);

  const handleBackToDashboard = () => {
    navigate("/home"); // Update with your dashboard route
  };

  return (
    <>
      <div className="flex justify-center font-bold text-4xl">
        Order Details
      </div>

      <div className="flex h-screen bg-gray-100">
        {/* Main Content Area */}
        <div className="w-3/4 p-6 bg-white shadow-lg rounded-lg space-y-6 overflow-y-auto">
          <div className="flex justify-between items-center mb-4">
            <h1 className="text-2xl font-bold text-gray-800">
              Manage Order #123456
            </h1>
            <button
              onClick={handleBackToDashboard}
              className="px-4 py-2 bg-teal-600 text-white rounded-lg shadow-md hover:bg-teal-700 transition"
            >
              Back to Dashboard
            </button>
          </div>

          {/* Order Summary Card */}
          <div className="bg-gray-50 p-4 rounded-lg shadow-md">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Order Summary
            </h2>
            <p>
              <strong>Order ID:</strong> #123456
            </p>
            <p>
              <strong>Order Date:</strong> August 28, 2024
            </p>
            <p>
              <strong>Total Amount:</strong> $250.00
            </p>
          </div>

          {/* Customer Details Card */}
          <div className="bg-gray-50 p-4 rounded-lg shadow-md">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Customer Details
            </h2>
            <p>
              <strong>Name:</strong> Jane Smith
            </p>
            <p>
              <strong>Address:</strong> ##
            </p>
            <p>
              <strong>Email:</strong> jane.smith@example.com
            </p>
            <p>
              <strong>Phone:</strong> (555) 123-4567
            </p>
          </div>

          {/* Store Details Card */}
          <div className="bg-gray-50 p-4 rounded-lg shadow-md">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Store Details
            </h2>
            <p>
              <strong>Store Name:</strong> Best Store
            </p>
            <p>
              <strong>Address:</strong> 123 Market Street, Cityville, ST, 12345
            </p>
            <p>
              <strong>Contact:</strong> (555) 987-6543
            </p>
          </div>

          {/* Order Status Card */}
          <div className="bg-gray-50 p-4 rounded-lg shadow-md">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Order Status
            </h2>
            <p>
              <strong>Status:</strong> {status}
            </p>
            <p>
              <strong>Estimated Delivery:</strong> {estimatedDelivery}
            </p>
            <p>
              <strong>Delivery Person:</strong> {deliveryPerson}
            </p>
          </div>
        </div>

        {/* Sidebar */}
        <div className="w-1/4 p-6 bg-[#613CB1] border-l border-gray-300 rounded-2xl">
          <h2 className="text-lg font-semibold text-white mb-4 flex justify-center">
            Order Management
          </h2>

          {/* Update Order Status */}
          <div className="mb-4">
            <label className="block text-sm font-medium text-gray-200 mb-2">
              Update Order Status
            </label>
            <select
              value={status}
              onChange={handleStatusChange}
              className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
            >
              <option value="Processing">Processing</option>
              <option value="Shipped">Shipped</option>
              <option value="Delivered">Delivered</option>
              <option value="Cancelled">Cancelled</option>
            </select>
          </div>

          {/* Set Estimated Delivery */}
          <div className="mb-4">
            <label className="block text-sm font-medium text-gray-200 mb-2">
              Estimated Delivery
            </label>
            <input
              type="date"
              value={estimatedDelivery}
              onChange={handleEstimatedDeliveryChange}
              className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
            />
          </div>

          {/* Assign Delivery Person */}
          <div>
            <label className="block text-sm font-medium text-gray-200 mb-2">
              Delivery Person
            </label>
            <input
              type="text"
              value={deliveryPerson}
              onChange={handleDeliveryPersonChange}
              className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
            />
          </div>
        </div>
      </div>
    </>
  );
};

export default ManageOrder;
