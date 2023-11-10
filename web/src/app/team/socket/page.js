"use client";
import React, { useState, useEffect, useRef } from "react";
import io from "socket.io-client";
import ChatBubble from "../chat/chatBuble";

// create random user
const user = "User_" + String(new Date().getTime()).substr(-3);

// component
const SocketChat = () => {
  const inputRef = useRef(null);

  // connected flag
  const [connected, setConnected] = useState(false);

  // init chat and message
  const [chat, setChat] = useState([]);
  const [msg, setMsg] = useState("");
  const [tmp, setTmp] = useState("");

  useEffect(() => {
    // connect to socket server
    const token = localStorage.getItem("token");
    const socket = io("https://sketch-dq5zwrwm5q-ww.a.run.app");

    console.log(socket);

    // log socket connection
    socket.on("connect", () => {
      console.log("SOCKET CONNECTED!", socket.id);
      setConnected(true);
    });

    // update chat on new message dispatched
    socket.on("message", (message) => {
      chat.push(message);
      setChat([...chat]);
    });
    socket.on("teams-chat-42d3aae7-e1a8-4a21-979f-316e9df7cc03", (message) => {
      const result = JSON.parse(message, null);
      console.log(result);
      chat.push(result);
      setChat([...chat]);
    });
    // socket disconnet onUnmount if exists
    return () => {
      socket.disconnect();
    };
  }, []);

  const sendMessage = async () => {
    const token = localStorage.getItem("token");
    const model = "image_from_text";

    if (msg) {
      const body = {
        sender: "user",
        content: {
          prompt: msg,
          chat: "",
          imageUser: "",
          imageAI: "",
          image: "",
          name: "",
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
      };
      chat.push(body);
      setChat([...chat]);
      setMsg("");

      // dispatch message to other users
      const res = await fetch(
        "https://the-architect.onrender.com/api/v1/chats/42d3aae7-e1a8-4a21-979f-316e9df7cc03/messages",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify({
            user_id: "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a",
            payload: {
              model:
                model == "text_to_image"
                  ? "xsarchitectural-interior-design"
                  : model == "painting"
                  ? "stable-diffusion-v1-5-inpainting"
                  : model == "instruction"
                  ? "instruct-pix2pix"
                  : "stable-diffusion-v1-5",
              prompt: msg,
              controlnet: "scribble-1.1",
              image: "",
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
            isTeam: true,
          }),
        }
      );

      console.log("res", res);
      chat.push(res);
      setChat([...chat]);
      setMsg("");

      // reset field if OK
      if (res.ok) {
        const response = await res.json();
        console.log("response", response);

        chat.push(response);
        setChat([...chat]);
        setMsg("");
        setTmp("");
      } else setMsg(tmp);
    }

    // focus after click
    inputRef?.current?.focus();
  };

  return (
    <div className="flex flex-col h-screen max-w-7xl">
      <div className="py-4 text-white w-full bg-green-500 sticky top-0 z-50">
        <h1 className="text-center text-2xl font-semibold">
          Collaborate and Design with your Team Live.
        </h1>
        {/* <h2 className="mt-2 text-center">in Next.js and Socket.io</h2> */}
      </div>
      <div className="flex flex-col flex-1 bg-gray-200 w-full ">
        <div className="flex-1 p-4 font-mono h-[90vh] ">
          {chat?.length > 0 &&
            chat.map((message, index) => {
              return <ChatBubble key={index} message={message} />;
            })}
        </div>
        <div className="bg-gray-400 p-4 h-20 sticky bottom-0">
          <div className="flex flex-row flex-1 h-full divide-gray-200 divide-x">
            <div className="pr-2 flex-1">
              <input
                ref={inputRef}
                type="text"
                value={msg}
                placeholder={connected ? "Type a message..." : "Connecting..."}
                className="w-full h-full rounded shadow border-gray-400 border px-2"
                disabled={!connected}
                onChange={(e) => {
                  setMsg(e.target.value);
                }}
                onKeyPress={(e) => {
                  if (e.key === "Enter") {
                    sendMessage();
                  }
                }}
              />
            </div>
            <div className="flex flex-col justify-center items-stretch pl-2">
              <button
                className="bg-blue-500 rounded shadow text-sm text-white h-full px-2"
                onClick={sendMessage}
                disabled={!connected}
              >
                SEND
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SocketChat;
