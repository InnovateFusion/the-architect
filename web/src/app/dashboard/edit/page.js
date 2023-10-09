import Image from "next/image";
import React from "react";
import Chat from "../chat/chat";

const ExampleComponent = () => {
  return (
    <div className="h-full sm:flex ">
      <div className="w-full sm:w-1/2 flex items-center justify-center p-4">
        <div className="aspect-square">
          <Image
            height={512}
            width={512}
            alt="gallery"
            src="/house.jpg"
            className="aspect-square"
          />
        </div>
      </div>
      <div className="w-full sm:w-1/2">
        <Chat />
      </div>
    </div>
  );
};

export default ExampleComponent;
