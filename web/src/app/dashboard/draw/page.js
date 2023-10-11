import Image from "next/image";
import React from "react";
import Chat from "../chat/chat";
import Canvas from "./Board";

const ExampleComponent = () => {
  return (
    <div className="h-full ">
      <div className="w-full  items-center justify-center p-4">
        <Canvas />
      </div>
    </div>
  );
};

export default ExampleComponent;
