import React, { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import otpimage from "../assets/otp.jpg";
import OTPInput from "otp-input-react";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

const OTP = () => {
  const [otp, setOTP] = useState("");
  const navigate = useNavigate();
  const location = useLocation();
  const { fpsId } = location.state || {};  

  const handleidChange = () => navigate("/");

  const handleResendEmail = async (e) => {
    e.preventDefault();

    console.log("Resend verification email to:", fpsId);
    toast.info("Verification email resent!", { autoClose: 3000 });

    try {
      const response = await axios.post("https://nfc3-lit-coders-i8r5.onrender.com/auth/send_otp_fps", {
        fps_id: fpsId,
      });

      if (response.status === 200) {
        toast.success("OTP sent successfully! Please check your email.", { autoClose: 3000 });
      } 
    } catch (error) {
      toast.error("FPS Id doesnt exist.", { autoClose: 3000 });
      console.error("Network error:", error);
    }
    
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(
        "https://nfc3-lit-coders-i8r5.onrender.com/auth/login_fps",
        {
          fps_id: fpsId,
          otp: otp,
        }
      );

      if (response.status === 200) {
        toast.success("OTP verified successfully!", { autoClose: 3000 });
        navigate("/home"); 
      } else {
        toast.error("Incorrect OTP. Please try again.", { autoClose: 3000 });
      }
    } catch (error) {
      toast.error("Network error. Please try again later.", { autoClose: 3000 });
      console.error("Error:", error);
    }
  };

  return (
    <div className="flex h-screen">
      <ToastContainer /> 
      <div className="absolute p-4 bg-[#613CB1] text-white text-3xl font-bold rounded-lg m-5">
        RationGo!
      </div>
      <div
        className="w-3/4 h-3/4 mt-11 bg-cover bg-center"
        style={{
          backgroundImage: `url(${otpimage})`,
          backgroundSize: "cover",
          backgroundRepeat: "no-repeat",
        }}
      ></div>

      <div className="w-1/2 flex flex-col items-center justify-center p-8 bg-white shadow-lg rounded-lg border border-gray-200">
        <h2 className="text-4xl font-extrabold text-[#613CB1] mb-6">
          Enter OTP
        </h2>
        <p className="text-gray-700 mb-8 text-lg">
          Please enter the 6-digit OTP sent to your email.
        </p>

        <form className="w-full max-w-sm" onSubmit={handleSubmit}>
          <div className="mb-6 bg-gray-100 p-4 rounded-lg shadow-inner">
            <OTPInput
              value={otp}
              onChange={setOTP}
              autoFocus
              OTPLength={6}
              otpType="number"
              disabled={false}
              className="w-full flex justify-center"
            />
          </div>
          <button
            type="submit"
            className="w-full bg-[#613CB1] hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          >
            Verify OTP
          </button>
        </form>

        <div className="mt-6 w-full flex flex-col items-start">
          <button
            onClick={handleResendEmail}
            className="text-[#613CB1] hover:text-blue-700 font-semibold mb-2"
          >
            Resend OTP
          </button>
          <p className="text-gray-600 mb-2 text-sm">Incorrect FPS-Id entered?</p>
          <button
            onClick={handleidChange}
            className="text-[#613CB1] hover:text-blue-700 font-semibold"
          >
            Correct your FPS-Id
          </button>
        </div>
      </div>
    </div>
  );
};

export default OTP;
