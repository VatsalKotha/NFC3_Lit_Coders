import React, { useEffect, useState } from "react";
import axios from "axios";

const CardContent = ({ cardTitle }) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const endpoint = getEndpointForCardTitle(cardTitle);
        const response = await axios.get(endpoint);
        setData(response.data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [cardTitle]);

  const getEndpointForCardTitle = (title) => {
    const endpoints = {
      "All Orders": "/api/orders/all",
      "Orders Placed": "/api/orders/placed",
      "Orders Out For Pickup": "/api/orders/out-for-pickup",
      "Orders Received": "/api/orders/received",
      "Orders Processing": "/api/orders/processing",
      "Orders Processed": "/api/orders/processed",
      "Orders Out For Delivery": "/api/orders/out-for-delivery",
      "Orders Delivered": "/api/orders/delivered",
      "Orders Cancelled": "/api/orders/cancelled",
    };
    return endpoints[title] || "/api/orders/all";
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: </div>;

  return (
    <>
      <h2 className="text-xl font-bold mb-4">{cardTitle}</h2>
      <div className="p-6 bg-white shadow-lg rounded-lg grid grid-cols-3 gap-6">
        {/* <pre>{JSON.stringify(data, null, 2)}</pre> */}
      </div>
    </>
  );
};

export default CardContent;
