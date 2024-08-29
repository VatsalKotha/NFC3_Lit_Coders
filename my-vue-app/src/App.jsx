// import { useState } from "react";
// import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
// import Home from "./pages/Home";

// function App() {
//   return (
//     <>
//       <Routes>
//         <Route path="/" element={<Login />} />
//       </Routes>
//     </> 
//   );
// }

// export default App;
// src/App.jsx
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from './pages/Home'; // Ensure this path is correct


function App() {
  return (
    <Router> {/* Wrap your Routes in a Router */}
      <Routes>
        <Route path="/" element={<Home />} /> {/* Ensure path and component match */}
      </Routes>
    </Router>
  );
}

export default App;
