"use client";
import React, { useRef } from "react";
import { ReactSketchCanvas } from "react-sketch-canvas";

const styles = {
  border: "0.0625rem solid #9c9c9c",
  borderRadius: "0.25rem",
};

const Canvas = () => {
  const canvasRef = useRef(null);

  const handleExportImage = () => {
    if (canvasRef.current) {
      canvasRef.current
        .exportImage("png")
        .then((data) => {
          console.log(data);
        })
        .catch((e) => {
          console.log(e);
        });
    }
  };

  return (
    <div className="h-full aspect-square p-4">
      <ReactSketchCanvas ref={canvasRef} strokeWidth={5} strokeColor="black" />
      <button onClick={handleExportImage}>Get Image</button>
    </div>
  );
};

export default Canvas;
