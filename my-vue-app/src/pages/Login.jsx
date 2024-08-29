import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import loginimage from "../assets/login.jpg";
import axios from "axios";

const Login = () => {
  const [fpsId, setFpsId] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post("https://nfc3-lit-coders-i8r5.onrender.com/auth/send_otp_fps", {
        fps_id: fpsId,
      });

      if (response.status == 200) {
        navigate("/otp");
      } else {
        console.error("Error:", data.msg);
      }
    } catch (error) {
      console.error("Network error:", error);
    }
  };
  return (
    <div className="flex h-screen">
      <div className="absolute p-4 bg-[#613CB1] text-white text-3xl font-bold rounded-lg m-5">
        RationGo!
      </div>
      <div
        className="w-3/4 h-3/4 mt-20 bg-cover bg-center"
        style={{
          backgroundImage: `url(${loginimage})`,
          backgroundSize: "cover",
          backgroundRepeat: "no-repeat",
        }}
      ></div>

      <div className="w-1/2 flex flex-col items-center justify-center p-8 bg-white shadow-lg rounded-lg border border-gray-200">
        <h2 className="text-4xl font-extrabold text-[#613CB1] mb-6">
          Welcome Back!
        </h2>
        <p className="text-gray-700 mb-8 text-lg">
          Please enter your FPS ID to continue.
        </p>

        <form className="w-full max-w-sm" onSubmit={handleSubmit}>
          <div className="mb-6 bg-gray-100 p-4 rounded-lg shadow-inner">
            <label
              className="block text-gray-700 text-sm font-semibold mb-2"
              htmlFor="fpsId"
            >
              FPS Id
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="fpsid"
              type="text"
              placeholder="Enter your FPS Id"
              onChange={(e) => setFpsId(e.target.value)}
              required
            />
          </div>
          <button
            type="submit"
            className="w-full bg-[#613CB1] hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          >
            Verify ID
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
