"use client";
import { useEffect, useRef, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Loader from "@/components/Loader";
import { useMessages } from "@/hooks/useTeam";
import ChatBubble from "../chatBuble";
import { AlertCircle } from "lucide-react";
export default function Chat({ params: { id } }) {
  const searchParams = useSearchParams();
  const router = useRouter();
  const { data: messages, isLoading, isError, error } = useMessages(id);
  const [message, setMessage] = useState("");
  const handleSend = () => {
    setMessage("");
  };


  if (isLoading) {
    return <Loader />;
  }

  // if (isError) {
  //   return <div>Error {error.message}</div>;
  // }

  return (
    <div className="h-full flex flex-col">
      <div
        className="p-2 border dark:border dark:border-gray-600 rounded-2xl mx-auto w-full space-y-4 bg-slate-300 overflow-y-auto h-[99vh]"
        id="chat-container"
        //   ref={messagesEndRef}
      >
        {messages?.length > 0 &&
          messages.map((chat, index) => {
            return <ChatBubble key={index} m={chat} />;
          })}
        {isLoading && <Loader />}
      </div>
      <h1 className="text-sm flex ">
        <AlertCircle size={20} /> The Generative AI model might produce
        incomplete and inaccurate data.
      </h1>
      <div>
        <div className="flex items-center py-2">
          <textarea
            autoFocus
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
            placeholder="Write your imagination here. The sky is the limit..."
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
    </div>
  );
}
