// import React, { useEffect, useState } from "react";
// import axios from "axios";

// const CardContent = ({ cardTitle }) => {
//   const [data, setData] = useState(null);
//   const [loading, setLoading] = useState(true);
//   const [error, setError] = useState(null);

//   useEffect(() => {
//     const fetchData = async () => {
//       try {
//         setLoading(true);
//         const endpoint = getEndpointForCardTitle(cardTitle);
//         const response = await axios.post(endpoint, {}, {
//           headers: {
//             'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNDk1MTg5MywianRpIjoiZjU2NTY5OWYtNTJlMS00MmQ1LTg4ZjUtMDQ3MWYwNjNhNjg2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJmcHNfaWQiOiJGUFMwMDIifSwibmJmIjoxNzI0OTUxODkzLCJleHAiOjE3MjUwMzgyOTN9.IT7lXkLkdYlSqBf3gIgMHoihDRC3ErduCtwUTk_evKc', // Replace with your token
//             'Content-Type': 'application/json'
//           }
//         });
//         setData(response.data);
//       } catch (err) {
//         setError(err.message);
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchData();
//   }, [cardTitle]);

//   const getEndpointForCardTitle = (title) => {
//     const baseURL = "https://nfc3-lit-coders-i8r5.onrender.com/fps/get_store_orders";
//     return baseURL;
//   };

//   if (loading) return <div>Loading...</div>;
//   if (error) return <div>Error: {error}</div>;

//   return (
//     <>
//       <h2 className="text-xl font-bold mb-4">{cardTitle}</h2>
//       <div className="p-6 bg-white shadow-lg rounded-lg grid grid-cols-3 gap-6">
//         {data && data.orders.length > 0 ? (
//           data.orders.map((order) => (
//             <div key={order.order_id} className="p-4 border border-gray-200 rounded-lg">
//               <h3 className="text-lg font-semibold">{order.order_id}</h3>
//               <p>Status: {order.order_status}</p>
//               <p>Expected Fulfilment Date: {order.expected_fulfilment_date}</p>
//               <p>Payment Method: {order.payment_method}</p>
//               {/* Render more details as needed */}
//             </div>
//           ))
//         ) : (
//           <p>No orders available</p>
//         )}
//       </div>
//     </>
//   );
// };

// export default CardContent;
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
        const endpoint = "https://nfc3-lit-coders-i8r5.onrender.com/fps/get_store_orders";
        const response = await axios.post(endpoint, {}, {
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNDk1MTg5MywianRpIjoiZjU2NTY5OWYtNTJlMS00MmQ1LTg4ZjUtMDQ3MWYwNjNhNjg2IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6eyJmcHNfaWQiOiJGUFMwMDIifSwibmJmIjoxNzI0OTUxODkzLCJleHAiOjE3MjUwMzgyOTN9.IT7lXkLkdYlSqBf3gIgMHoihDRC3ErduCtwUTk_evKc',
            'Content-Type': 'application/json'
          }
        });
        setData(response.data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [cardTitle]);

  const filterOrders = (orders, cardTitle) => {
    const statusFromCardTitle = cardTitle.replace("Orders ", "");
    console.log(`Filtering orders with status: ${statusFromCardTitle}`); // Debugging line
    if (cardTitle === "All Orders") return orders;
    return orders.filter(order => order.order_status === statusFromCardTitle);
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <>
      <h2 className="text-xl font-bold mb-4">{cardTitle}</h2>
      <div className="p-6 bg-white shadow-lg rounded-lg grid grid-cols-3 gap-6">
        {data && data.orders.length > 0 ? (
          filterOrders(data.orders, cardTitle).map((order) => (
            <div key={order.order_id} className="p-4 border border-gray-200 rounded-lg">
              <h3 className="text-lg font-semibold">{order.order_id}</h3>
              <p>Status: {order.order_status}</p>
              <p>Expected Fulfilment Date: {order.expected_fulfilment_date}</p>
              <p>Payment Method: {order.payment_method}</p>
              {/* Render more details as needed */}
            </div>
          ))
        ) : (
          <p>No orders available</p>
        )}
      </div>
    </>
  );
};

export default CardContent;
