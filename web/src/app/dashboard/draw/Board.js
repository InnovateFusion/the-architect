"use client";
import React, { useRef } from "react";
import { Excalidraw } from "@excalidraw/excalidraw";
import { useState, useEffect } from "react";

const styles = {
  border: "0.0625rem solid #9c9c9c",
  borderRadius: "0.25rem",
};


/**
 * Handles exporting the image.
 *
 * @return {void} 
 */


const Canvas = () => {
  
  const canvasRef = useRef(null);
  const [Excalidraw, setExcalidraw] = useState(null);

  useEffect(() => {
    import("@excalidraw/excalidraw").then((comp) => setExcalidraw(comp.Excalidraw));
    console.log(Excalidraw)
  }, []);

/**
 * Handles exporting the image.
 *
 * @return {void} 
 */

  const handleExportImage = () => {
    if (canvasRef.current && canvasRef.current.toDataURL) {
      const dataUrl = canvasRef.current.toDataURL();
      setImageData(dataUrl);
      sendImageToBackend(dataUrl);
    } else {
      console.error("canvasRef is null or doesn't have toDataURL method");
    }
  };

/**
 * Sends the image data to the backend API for uploading.
 *
 * @param {type} imageData - The image data to be uploaded.
 * @return {type} This function does not return anything.
 */

  const sendImageToBackend = (imageData) => {
    fetch("/api/upload-image", {
      method: "POST",
      body: JSON.stringify({ image: imageData }),
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  };

  return (
    <div className="h-600 aspect-square p-4">
       {Excalidraw && <Excalidraw ref={canvasRef}
          width={600}
          height={'100vh'}
          initialData={{
            elements: [],
            appState: {},
          }}/>} 
    </div>
  );
};

export default Canvas;