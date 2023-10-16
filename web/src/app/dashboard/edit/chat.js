"use client";

import Image from "next/image";
import { useEffect, useRef, useState } from "react";
import { useSearchParams } from "next/navigation";

export default function Chat({ changeImage }) {
  const [chats, setChats] = useState([]);
  const [message, setMessage] = useState("");
  const [model, setModel] = useState("text_to_image");
  const [url, setUrl] = useState(
    `https://the-architect.onrender.com/api/v1/chats`
  );
  const [currentChat, setCurrentChat] = useState("");
  const searchParams = useSearchParams();

  const [chatId, setChatId] = useState(searchParams.get("chatId"));

  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };
  const handleSend = async () => {
      setMessage("");
      setChats([
        ...chats,
        JSON.stringify({
          sender: "user",
          content: message,
          logo: "/if.png",
        }),
      ]);
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");

    if (chatId != null)
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );

    const res = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({
        user_id: userId,
        payload: {
          model: "xsarchitectural-interior-design",
          prompt: message,
          negative_prompt: "Disfigured, cartoon, blurry",
          width: 512,
          height: 512,
          steps: 25,
          guidance: 7.5,
          seed: 0,
          scheduler: "dpmsolver++",
          output_format: "jpeg",
        },
        model: model,
      }),
    });
    if (res.status == 200) {
      const chat = await res.json();
      console.log(chatId)
      if (chatId != null) {
        console.log("chat full");
        console.log(chat);
        setChats([...chats, JSON.stringify(chat)]);
      } else {
        console.log("chat less");
        console.log(chat);
        setChats([...chats, ...chat.messages]);
        setChatId(chat.id);
      }
      scrollToBottom();
    }
  };

  const getChat = async () => {
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");

    const url = `https://the-architect.onrender.com/api/v1/chats/${chatId}`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    if (res.status == 200) {
      const posts = await res.json();
      setChats([...posts.messages]);
    }
  };

  useEffect(() => {
    if (chatId != null) {
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );
      getChat();
      messagesEndRef.current.scrollIntoView({ behavior: "smooth" });
    }
  }, []);

  return (
    <div className="h-full flex flex-col">
      <div className=" hidden gap-x-4 p-1">
        <select
          className="select select-primary"
          defaultValue={model}
          onChange={(e) => setModel(e.target.value)}
        >
          <option disabled>Select Project</option>
          <option value="new">New Project</option>
          {}
        </select>
        <select
          className="select select-secondary"
          defaultValue={model}
          onChange={(e) => setModel(e.target.value)}
        >
          <option disabled>Choose your model here.</option>
          <option value="text_to_image">Idea to Design</option>
          <option value="image_to_image">Design Variation</option>
          <option value="controlNet">Drawing to Design</option>
          <option value="painting">Design Modification</option>
          <option value="instruction">Edit my Design</option>
        </select>
      </div>
      <div className="border  bg-slate-300 overflow-y-auto h-[99%]">
        {chats.length > 0 ? (
          chats.map((item, index) => {
            const chat = JSON.parse(item);
            return (
              <div
                className={`chat chat-${chat.sender == "ai" ? "start" : "end"}`}
                ref={messagesEndRef}
                key={index}
              >
                <div className="chat-image avatar">
                  <div className="w-12 rounded-full p-1">
                    <Image src="/logo.svg" width={200} alt="" height={200} />
                  </div>
                </div>
                <div className="chat-bubble">
                  {chat.sender == "ai" && chat.content ? (
                    <Image
                      src={chat.content}
                      width={200}
                      alt=""
                      height={200}
                      onClick={() => {
                        changeImage(chat.content);
                      }}
                      className="hover:cursor-pointer"
                    />
                  ) : (
                    chat.content
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
            multiple
            min={2}
          />
          {message != "" && <button
            type="submit"
            className="flex-shrink-0 bg-blue-500 hover:bg-blue-700 border-blue-500 hover:border-blue-700 text-sm border-4 text-white py-1 px-2 rounded mx-5"
            onClick={handleSend}
            onKeyDown={(e) => {
              e.key == "Enter" && console.log("hih");
            }}
          >
            Generate
          </button>}
        </div>
      </div>
    </div>
  );
}
