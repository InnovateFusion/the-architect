"use client";
import Image from "next/image";
import React, { useState } from "react";
import Chat from "../chat/chat";

const ExampleComponent = () => {
  const [image, setImage] = useState("/house.jpg");
  const handleChangeImage = (link) => {
    setImage(link);
    console.log(link);
  };
  return (
    <div className="h-full sm:flex ">
      <div className="w-full sm:w-1/2 flex items-center justify-center p-4">
        <div className="aspect-square">
          <Image
            height={512}
            width={512}
            alt="gallery"
            src={image}
            className="aspect-square"
          />
        </div>
      </div>
      <div className="w-full sm:w-1/2">
        <Chat changeImage={(link) => handleChangeImage(link)} />
      </div>
    </div>
  );
};

export default ExampleComponent;
