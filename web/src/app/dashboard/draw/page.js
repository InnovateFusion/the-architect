import Image from "next/image";
import React from "react";
import Chat from "../chat/chat";
import Canvas from "./Board";

const ExampleComponent = () => {
  return (
    <div className="h-full sm:flex ">
      <div className="w-full sm:w-1/2 flex items-center justify-center p-4">
        <Canvas />
      </div>
      <div className="w-full sm:w-1/2">
        <Chat />
      </div>
    </div>
  );
};

export default ExampleComponent;
