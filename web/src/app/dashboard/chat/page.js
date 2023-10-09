"use client";
import Image from "next/image";
import React, { useState } from "react";
import Chat from "./chat";
import List from "./list";

function ChatWindow() {
  const [isOpen, setIsOpen] = useState(false);

  const toggleChatWindow = () => {
    setIsOpen(!isOpen);
  };

  return (
    <>
      <List />
      <div className="fixed bottom-0 right-0 m-4">
        <button
          className="btn"
          onClick={() => {
            document.getElementById("my_modal_1").showModal();
          }}
        >
          open modal
        </button>
        <dialog id="my_modal_1" className="modal overflow-y-scroll">
          <Chat />
        </dialog>
        <button
          className="bg-blue-500 text-white px-4 py-2 rounded-full shadow-lg"
          onClick={toggleChatWindow}
        >
          Open Chat
        </button>

        {isOpen && (
          <div className="fixed bottom-16 right-4 bg-white rounded-lg shadow-lg w-1/2 h-4/6 overflow-y-auto">
            {/* Chat header */}
            <div className="bg-blue-500 text-white px-4 py-2 rounded-t-lg">
              Chat with Support
            </div>

            {/* Chat content */}
            <div className="p-4">
              {/* Example chat messages */}
              <div className="flex items-start mb-4">
                <Image
                  width={100}
                  height={100}
                  src="/logo.svg"
                  alt="User Avatar"
                  className="w-8 h-8 rounded-full mr-2"
                />
                <div className="bg-blue-100 rounded-lg p-2">
                  Hello! How can I help you today?
                </div>
              </div>

              <div className="flex items-end justify-end mb-4">
                <div className="bg-green-100 rounded-lg p-2">
                  Hi there! I have a question about my order.
                </div>
                <Image
                  width={100}
                  height={100}
                  src="/if.png"
                  alt="Support Avatar"
                  className="w-8 h-8 rounded-full ml-2"
                />
              </div>

              {/* Image support */}
              <div className="flex items-start mb-4">
                <Image
                  width={100}
                  height={100}
                  src="/logo.svg"
                  alt="User Avatar"
                  className="w-8 h-8 rounded-full mr-2"
                />
                <div className="bg-blue-100 rounded-lg p-2">
                  Here's an image:
                  <Image
                    width={100}
                    height={100}
                    src="/house.jpg"
                    alt="User Image"
                    className="mt-2 max-w-xs rounded-lg"
                  />
                </div>
              </div>
            </div>

            {/* Chat input */}
            <div className="bg-gray-100 p-2 rounded-b-lg">
              <input
                type="text"
                placeholder="Type your message..."
                className="w-full px-2 py-1 rounded-full border focus:outline-none"
              />
            </div>
          </div>
        )}
      </div>
    </>
  );
}

export default ChatWindow;
