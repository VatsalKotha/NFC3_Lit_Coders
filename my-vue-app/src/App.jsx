import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Login from './pages/Login';
import OTP from "./pages/OTP"
import Home from "./pages/Home"
import Footer from './Components/Footer';
import Inventory from './pages/Inventory';

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/otp" element={<OTP />} />
        <Route path='/home' element={<Home/>}></Route>
        <Route path="/inventory" element={<Inventory />} />
      </Routes>
    </Router>
    </>
  );
}

export default App;
