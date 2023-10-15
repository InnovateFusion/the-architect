"use client";
import Image from "next/image";
import React, { useState } from "react";
import Chat from "../edit/chat";
import Canvas from "./Board";

const ExampleComponent = () => {
  const [image, setImage] = useState("/house.jpg");
  const handleChangeImage = (link) => {
    setImage(link);
    console.log(link);
  };
  return (
    <div className="h-full sm:flex justify-around">
      <div className="w-full sm:w-1/2 h-full items-center justify-center px-14">
        <Canvas />
      </div>
      <div className="w-full sm:w-1/2">
        <Chat changeImage={(link) => handleChangeImage(link)} />
      </div>
    </div>
  );
};

export default ExampleComponent;
