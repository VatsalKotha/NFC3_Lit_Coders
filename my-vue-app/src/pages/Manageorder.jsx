import React, { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import axios from "axios";

const ManageOrder = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { fps_id, order_id } = location.state || {};

  const [orderDetails, setOrderDetails] = useState(null);
  const [status, setStatus] = useState("");
  const [estimatedDelivery, setEstimatedDelivery] = useState("");
  const [deliveryPerson, setDeliveryPerson] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (!fps_id || !order_id) {
      console.error("Missing order data");
      navigate("/home");
      return;
    }

    const fetchOrderDetails = async () => {
      try {
        setLoading(true);
        const endpoint = "https://nfc3-lit-coders-i8r5.onrender.com/fps/get_store_orders";
        const response = await axios.post(endpoint, { fps_id, order_id }, {
          headers: {
            'Authorization': `Bearer ${import.meta.env.VITE_ACCESS_TOKEN}`,
            'Content-Type': 'application/json'
          }
        });

        const orderData = response.data.orders.find(order => order.order_id === order_id);
        setOrderDetails(orderData);
        if (orderData) {
          setStatus(orderData.order_status);
          setEstimatedDelivery(orderData.expected_fulfilment_date);
        }
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchOrderDetails();
  }, [fps_id, order_id, navigate]);

  const handleStatusChange = (e) => setStatus(e.target.value);
  const handleEstimatedDeliveryChange = (e) => setEstimatedDelivery(e.target.value);
  const handleDeliveryPersonChange = (e) => setDeliveryPerson(e.target.value);

  const handleUpdateOrder = async () => {
    try {
      const endpoint = "https://nfc3-lit-coders-i8r5.onrender.com/fps/update_order";
      const response = await axios.post(endpoint, {
        fps_id,
        order_id,
        order_status: status,
        estimated_fulfilment_date: estimatedDelivery,
      }, {
        headers: {
          'Authorization': `Bearer ${import.meta.env.VITE_ACCESS_TOKEN}`,
          'Content-Type': 'application/json'
        }
      });

      if (response.status === 200) {
        alert("Order status updated successfully!");
      } else {
        alert("Failed to update order status.");
      }
    } catch (err) {
      setError(err.message);
    }
  };

  const handleBackToDashboard = () => {
    navigate("/home");
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

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
              Manage Order #{order_id}
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
            {orderDetails ? (
              <>
                <p>
                  <strong>Order ID:</strong> {orderDetails.order_id}
                </p>
                <p>
                  <strong>Order Date:</strong> {new Date(orderDetails.created_at).toLocaleDateString()}
                </p>
                <p>
                  <strong>Total Amount:</strong> ${orderDetails.total_amount.toFixed(2)}
                </p>
              </>
            ) : (
              <p>No order details available</p>
            )}
          </div>

          {/* Customer Details Card */}
          {orderDetails && orderDetails.user && (
            <div className="bg-gray-50 p-4 rounded-lg shadow-md">
              <h2 className="text-xl font-semibold text-gray-800 mb-2">
                Customer Details
              </h2>
              <p>
                <strong>Name:</strong> {orderDetails.user.name}
              </p>
              <p>
                <strong>Address:</strong> {orderDetails.user.address}
              </p>
              <p>
                <strong>Email:</strong> {orderDetails.user.email}
              </p>
              <p>
                <strong>Phone:</strong> {orderDetails.user.contact_number}
              </p>
            </div>
          )}

          {/* Store Details Card */}
          {orderDetails && (
            <div className="bg-gray-50 p-4 rounded-lg shadow-md">
              <h2 className="text-xl font-semibold text-gray-800 mb-2">
                Store Details
              </h2>
              <p>
                <strong>Store Name:</strong> {orderDetails.user.fps_name}
              </p>
              <p>
                <strong>Address:</strong> {orderDetails.user.address}
              </p>
              <p>
                <strong>Contact:</strong> {orderDetails.user.contact_number}
              </p>
            </div>
          )}

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

          {/* Products Card */}
          {orderDetails && orderDetails.products && (
            <div className="bg-gray-50 p-4 rounded-lg shadow-md">
              <h2 className="text-xl font-semibold text-gray-800 mb-2">
                Products
              </h2>
              <ul className="list-disc list-inside pl-4">
                {orderDetails.products.map((product, index) => (
                  <li key={index} className="mb-2">
                    <p><strong>Product Name:</strong> {product.product_name}</p>
                    <p><strong>Quantity:</strong> {product.quantity}</p>
                    <p><strong>Price:</strong> ${product.actual_price.toFixed(2)}</p>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {/* Update Order Status Card */}
          <div className="bg-gray-50 p-4 rounded-lg shadow-md">
            <h2 className="text-xl font-semibold text-gray-800 mb-2">
              Update Order Status
            </h2>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-800 mb-2">
                Order Status
              </label>
              <select
                value={status}
                onChange={handleStatusChange}
                className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
              >
                <option value="Processing">Processing</option>
                <option value="Received">Received</option>
                <option value="Processed">Processed</option>
                <option value="Out For Delivery">Out For Delivery</option>
                <option value="Delivered">Delivered</option>
                <option value="Cancelled">Cancelled</option>
              </select>
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-800 mb-2">
                Estimated Delivery
              </label>
              <input
                type="date"
                value={estimatedDelivery}
                onChange={handleEstimatedDeliveryChange}
                className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-800 mb-2">
                Delivery Person
              </label>
              <input
                type="text"
                value={deliveryPerson}
                onChange={handleDeliveryPersonChange}
                className="w-full p-2 border border-gray-300 rounded-md bg-white text-gray-800 shadow-md"
              />
            </div>

            <button
              onClick={handleUpdateOrder}
              className="mt-4 px-4 py-2 bg-blue-600 text-white rounded-lg shadow-md hover:bg-blue-700 transition"
            >
              Update Order
            </button>
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
                <option value="Received">Received</option>
                <option value="Processed">Processed</option>
                <option value="Out For Delivery">Out For Delivery</option>
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

          <button
            onClick={handleUpdateOrder}
            className="mt-4 px-4 py-2 bg-blue-600 text-white rounded-lg shadow-md hover:bg-blue-700 transition"
          >
            Update Order
          </button>
        </div>
      </div>
    </>
  );
};

export default ManageOrder;
