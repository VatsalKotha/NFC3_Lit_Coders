// src/Components/Chat/Chat.jsx
import React, { useState, useEffect } from 'react';
import { FaPaperPlane } from 'react-icons/fa';

const Chat = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');

  const handleSend = () => {
    if (input.trim()) {
      setMessages([...messages, { text: input, sender: 'user' }]);
      setInput('');
      // Simulate receiving a response from the store
      setTimeout(() => {
        setMessages([...messages, { text: input, sender: 'user' }, { text: 'Response from store', sender: 'store' }]);
      }, 1000);
    }
  };

  return (
    <div className="flex flex-col h-full max-w-lg mx-auto p-4 bg-white shadow-lg rounded-lg">
      <div className="flex-1 overflow-y-auto p-2 border-b border-gray-200">
        {messages.map((msg, index) => (
          <div key={index} className={`my-2 ${msg.sender === 'user' ? 'text-right' : 'text-left'}`}>
            <p className={`inline-block px-4 py-2 rounded-lg ${msg.sender === 'user' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-black'}`}>
              {msg.text}
            </p>
          </div>
        ))}
      </div>
      <div className="flex items-center p-2 border-t border-gray-200">
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          className="flex-1 p-2 border border-gray-300 rounded-lg"
          placeholder="Type your message..."
        />
        <button onClick={handleSend} className="ml-2 p-2 bg-blue-500 text-white rounded-lg">
          <FaPaperPlane />
        </button>
      </div>
    </div>
  );
};

export default Chat;
