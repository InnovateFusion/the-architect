import Image from "next/image";
import React from "react";
import { Capitalize } from "@/utils/utils";

function ChatBubble({ m, handleOpen, setImage }) {
  const message = JSON.parse(m);
  return (
    <div
      className={`p2-3 flex justify-${
        message?.sender == "user" ? "end" : "start"
      }`}
    >
      <div
        className={`flex w-10/12 ${
          message?.sender == "user" && "flex-row-reverse"
        }`}
      >
        <div className="mr-4" />
        <div
          className={`relative  rounded-xl rounded-t${
            message?.sender == "user" ? "r" : "l"
          }-none ${
            message?.sender == "user"
              ? "bg-blue-600 max-w-[300px]"
              : "bg-gray-600 max-w-xl"
          } px-4 py-2`}
        >
          <span
            className={`text-sm font-medium  text-wrap ${
              message?.sender == "user" ? "text-white" : "text-heading"
            } `}
          >
            {message?.content?.imageUser &&
              message?.content?.imageUser != "" && (
                <Image
                  src={message?.content?.imageUser}
                  width={300}
                  alt=""
                  height={300}
                  className="hover:cursor-pointer"
                  onClick={(e) => setImage(message.content.imageUser)}
                  onDoubleClick={(e) => handleOpen(message.content.imageUser)}
                />
              )}
            {message?.content?.imageAI && message?.content?.imageAI != "" && (
              <Image
                src={message?.content?.imageAI}
                width={300}
                alt=""
                height={300}
                className="hover:cursor-pointer"
                onClick={(e) => setImage(message.content.imageAI)}
                onDoubleClick={(e) => handleOpen(message.content.imageAI)}
              />
            )}
            {message.model == "text_to_3D" && message?.content["3D"]?.fetch_result &&
              message?.content["3D"]?.fetch_result != "" &&
              JSON.stringify(message?.content["3D"]?.fetch_result) != "{}" && (
                <Image
                  src={message?.content["3D"]?.fetch_result}
                  width={300}
                  alt=""
                  height={300}
                  className="hover:cursor-pointer"
                  onClick={(e) => setImage(message.content["3D"].fetch_result)}
                  onDoubleClick={(e) =>
                    handleOpen(message.content["3D"].fetch_result)
                  }
                />
              )}
            {message?.content?.prompt}
            {message?.content?.analysis?.title != undefined && (
              <h1 className="text-bold">
                {Capitalize(message?.content?.analysis?.title)}
              </h1>
            )}
            {message?.content?.chat}
            {message?.content?.analysis?.detail}
            {message?.content?.analysis?.details}
          </span>
        </div>
      </div>
    </div>
  );
}

export default ChatBubble;
