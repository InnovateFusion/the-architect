"use client";
import Image from "next/image";
import ImageZoom from "react-image-zooom";

import { useEffect, useRef, useState } from "react";
import { useSearchParams } from "next/navigation";
import ChatBuble from "./chatBuble";
import { PostDesign } from "./PostDesign";
import { initialMessage, models } from "../../../utils/constant";

async function imageUrlToBase64(url, callback) {
  // Fetch the image
  await fetch(url)
    .then((response) => response.blob())
    .then((blob) => {
      const reader = new FileReader();
      reader.onload = function () {
        const base64String = reader.result.split(",")[1];
        callback(base64String);
      };
      return reader.readAsDataURL(blob);
    })
    .catch((error) => {
      console.error("Error fetching and converting image:", error);
      callback(null);
    });
}

export default function Chat() {
  const searchParams = useSearchParams();
  const [image, setImage] = useState("/house.jpg");
  const [chats, setChats] = useState(initialMessage);
  const [message, setMessage] = useState("");
  const [model, setModel] = useState(
    searchParams.get("model") || "text_to_image"
  );
  const [url, setUrl] = useState(
    `https://the-architect.onrender.com/api/v1/chats`
  );

  const [open, setOpen] = useState(false);
  const handleOpen = () => {
    setOpen(!open);
    !open && setImage(image);
  };

  const [chatId, setChatId] = useState(searchParams.get("chatId"));

  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    if (messagesEndRef.current) {
      const chatContainer = messagesEndRef.current;
      const lastMessage = chatContainer.lastChild;
      lastMessage.scrollIntoView({ behavior: "smooth" });
    }
    console.log(messagesEndRef);
  };
  const handleSend = async () => {
    imageUrlToBase64(image, (base64String) => {
      if (base64String) {
        setImage(base64String);
      } else {
        console.log("Failed to convert image to base64");
        return;
      }
    });
    setChats((oldArray) => [
      ...oldArray,
      JSON.stringify({
        sender: "user",
        content: {
          prompt: message,
          chat: "",
          imageUser: "",
          imageAI: "",
          model: model,
          analysis: {
            title: "",
            detail: "",
          },
          "3D": {
            status: "",
            fetch_result: "",
          },
        },
      }),
    ]);
    scrollToBottom();

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
          controlnet: "scribble-1.1",
          image: image,
          negative_prompt: "Disfigured, cartoon, blurry",
          mask_image: "",
          strength: 0.5,
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
      if (chatId != null) {
        const x = JSON.stringify(chat);
        setChats((oldArray) => [...oldArray, x]);
      } else {
        setChats([...chats, ...chat.messages]);
        setChatId(chat.id);
      }
      scrollToBottom();
      setMessage("");
    }
  };

  useEffect(() => {
    if (chatId != null) {
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );

      const getChat = async () => {
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
      getChat();
      scrollToBottom();
    }
  }, []);

  return (
    <div className="h-full sm:flex ">
      <div className="w-full sm:w-1/2 flex items-center justify-center p-4">
        <div>
          <ImageZoom
            height={512}
            width={512}
            alt="gallery"
            src={image}
            className="rounded-lg border"
          />
        </div>
      </div>
      <div className="w-full sm:w-1/2">
        <div className=" gap-x-4 p-1">
          <select
            className="block w-full border-1  rounded-lg px-4 py-2 outline-none focus:ring focus:ring-indigo-400"
            defaultValue={model}
            onChange={(e) => setModel(e.target.value)}
          >
            <option disabled>Choose your model here.</option>
            {models.map((m, i) => (
              <option key={i} value={m.code}>
                {m.name}
              </option>
            ))}
          </select>
        </div>
        <div className="h-[97%] flex flex-col">
          <div
            className="p-2 border rounded-2xl mx-auto w-full space-y-4 bg-slate-300 overflow-y-auto h-[99vh]"
            id="chat-container"
            ref={messagesEndRef}
          >
            {chats.length > 0 &&
              chats.map((chat, index) => {
                return (
                  <ChatBuble
                    key={index}
                    m={chat}
                    handleOpen={handleOpen}
                    setImage={setImage}
                  />
                );
              })}
          </div>
          <div>
            <div className="flex items-center py-2">
              <textarea
                className="block w-full rounded-lg px-4 py-2 mx-2 outline-none focus:ring focus:ring-indigo-400 resize-none dark:bg-gray-800 dark:border dark:border-gray-600 dark:text-white bg-white border border-gray-300 text-black"
                rows="2"
                onChange={(e) => {
                  setMessage(e.target.value);
                }}
                value={message}
                min={2}
                onKeyDown={(e) => {
                  if (e.key === "Enter" && message != "") {
                    e.preventDefault();
                    handleSend();
                  }
                }}
              />
              {message != "" && (
                <button
                  type="submit"
                  className="flex-shrink-0 bg-blue-500 hover:bg-blue-700 border-blue-500 hover:border-blue-700 text-sm border-4 text-white py-1 px-2 rounded mx-5"
                  onClick={handleSend}
                >
                  Generate
                </button>
              )}
            </div>
          </div>
          <PostDesign open={open} handleOpen={handleOpen} image={image} />
        </div>
      </div>
    </div>
  );
}
