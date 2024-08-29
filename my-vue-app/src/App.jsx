import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Login from './pages/Login';
import OTP from "./pages/OTP"
import Home from "./pages/Home"
import Footer from './Components/Footer';

function App() {
  return (
    <>
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/otp" element={<OTP />} />
        <Route path='/home' element={<Home/>}></Route>
      </Routes>
    </Router>
    </>
  );
}

export default App;
