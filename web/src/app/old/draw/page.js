"use client";
import Image from "next/image";
import React, { useRef, useState } from "react";
import Chat from "../edit/chat";
import Canvas from "./Board";
import { ExcalidrawPage } from "./ExcalidrawPage";

const ExampleComponent = () => {
  const [image, setImage] = useState("");
  const excalidrawRef = useRef(null);
  const exportToCanvasRef = useRef(null);
  const handleChangeImage = (link) => {
    setImage(link);
    console.log(link);
  };

  async function getCanvasUrl() {
    if (!excalidrawRef.current?.ready) return;

    const elements = excalidrawRef.current.getSceneElements();
    if (!elements || !elements.length) {
      return;
    }

    const canvas = await exportToCanvasRef.current({
      elements: elements,
      mimeType: "image/png",
      //appState: excalidrawRef.current.getAppState(),
      files: excalidrawRef.current.getFiles(),
      getDimensions: () => {
        return { width: 512, height: 512 };
      }, // experiment with this for cheaper replicate API.
    });

    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    ctx.font = "30px Virgil";
    return canvas.toDataURL();
  }

  const handleSubmit = async (e) => {
    // e.preventDefault();
    console.log("createPrediction.....");

    const canvasUrl = await getCanvasUrl();
    if (!canvasUrl) {
      setImage("");
      return;
    }
    setImage(canvasUrl.substr(22));
  };

  return (
    <div className="h-full sm:flex justify-around">
      <div className="w-full sm:w-1/2 h-full items-center justify-center px-14">
        {/* <Canvas /> */}

        <ExcalidrawPage
          excalidrawRef={excalidrawRef}
          exportToCanvasRef={exportToCanvasRef}
          changeImage={handleChangeImage}
        />
      </div>
      <div className="w-full sm:w-1/2">
        <Chat changeImage={handleSubmit} mode="controlNet" image={image} />
      </div>
    </div>
  );
};

export default ExampleComponent;
