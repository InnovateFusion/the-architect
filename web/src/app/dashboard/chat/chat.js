"use client";

import Image from "next/image";
import { useEffect, useRef, useState } from "react";

export default function Chat({ changeImage }) {
  const [chats, setChats] = useState([
    {
      name: "bot",
      type: "image",
      message: "Hi there",
      image: "/logo.svg",
      logo: "/logo.svg",
    },
    {
      name: "user",
      type: "message",
      message: "Hi there",
      image: "/if.png",
      logo: "/if.png",
    },
    {
      name: "bot",
      type: "message",
      message: "Hi there",
      image: "/logo.svg",
      logo: "/logo.svg",
    },
    {
      name: "user",
      type: "image",
      message: "Hi there",
      image: "/if.png",
      logo: "/if.png",
    },
    {
      name: "bot",
      type: "image",
      message: "Hi there",
      image: "/logo.svg",
      logo: "/logo.svg",
    },
    {
      name: "user",
      type: "message",
      message: "Hi there",
      image: "/if.png",
      logo: "/if.png",
    },
    {
      name: "bot",
      type: "image",
      message: "Hi there",
      image: "/house.jpg",
      logo: "/logo.svg",
    },
  ]);
  const [message, setMessage] = useState("");

  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };
  const handleSend = () => {
    setChats([
      ...chats,
      {
        name: "user",
        type: "message",
        message: message,
        image: "/if.png",
        logo: "/if.png",
      },
    ]);
    setMessage("");
    scrollToBottom();
  };

  useEffect(() => {
    messagesEndRef.current.scrollIntoView({ behavior: "smooth" });
  }, [chats.length]);

  return (
    <>
      <div className="border  bg-slate-300 overflow-y-auto h-[90%]">
        {chats.length > 0 ? (
          chats.map((item, index) => {
            return (
              <div
                className={`chat chat-${item.name == "bot" ? "start" : "end"}`}
                ref={messagesEndRef}
                key={index}
              >
                <div className="chat-image avatar">
                  <div className="w-12 rounded-full p-1">
                    <Image src={item.logo} width={200} alt="" height={200} />
                  </div>
                </div>
                <div className="chat-bubble">
                  {item.type == "image" ? (
                    <Image
                      src="/logo.svg"
                      width={200}
                      alt=""
                      height={200}
                      onClick={() => {
                        changeImage(item.image);
                        console.log("yay");
                      }}
                      className="hover:cursor-pointer"
                    />
                  ) : (
                    item.message
                  )}
                </div>
              </div>
            );
          })
        ) : (
          <>
            <div className="chat chat-start" ref={messagesEndRef}>
              <div className="chat-image avatar">
                <div className="w-12 rounded-full p-3">
                  <Image src="/logo.svg" width={200} alt="" height={200} />
                </div>
              </div>
              <div className="chat-bubble">
                <Image src="/logo.svg" width={200} alt="" height={200} />
              </div>
            </div>
            <div className="chat chat-end">
              <div className="chat-image avatar">
                <div className="w-12 rounded-full">
                  <Image src="/if.png" width={200} alt="" height={200} />
                </div>
              </div>
              <div className="chat-bubble">Make it more lighter</div>
            </div>
          </>
        )}
      </div>

      <div>
        <div className="flex items-center border-2 border-red-700 py-2">
          <input
            type="text"
            placeholder="Type a message..."
            className="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
            onChange={(e) => {
              setMessage(e.target.value);
            }}
            value={message}
          />
          <button
            type="submit"
            className="flex-shrink-0 bg-blue-500 hover:bg-blue-700 border-blue-500 hover:border-blue-700 text-sm border-4 text-white py-1 px-2 rounded"
            onClick={handleSend}
            onKeyDown={(e) => {
              e.key == "Enter" && console.log("hih");
            }}
          >
            Send
          </button>
        </div>
      </div>
    </>
  );
}
