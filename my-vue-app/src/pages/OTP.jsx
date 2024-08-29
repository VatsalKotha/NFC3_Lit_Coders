import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import otpimage from "../assets/otp.jpg";
import OTPInput from "otp-input-react";

const OTP = () => {
  const [email, setEmail] = useState("");
  const [OTP, setOTP] = useState("");
  const navigate = useNavigate();

  const handleEmailChange = () => navigate("/");
  const handleResendEmail = () => {
    console.log("Resend verification email to:", email);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log("OTP submitted:", OTP);
  };

  return (
    <div className="flex h-screen">
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
              value={OTP}
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
            Resend Email
          </button>
          <p className="text-gray-600 mb-2 text-sm">Incorrect email entered?</p>
          <button
            onClick={handleEmailChange}
            className="text-[#613CB1] hover:text-blue-700 font-semibold"
          >
            Correct your Email
          </button>
        </div>
      </div>
    </div>
  );
};

export default OTP;
