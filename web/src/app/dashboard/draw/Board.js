"use client";
import React, { useRef } from "react";
import { Excalidraw } from "@excalidraw/excalidraw";
import { useState, useEffect } from "react";

const styles = {
  border: "0.0625rem solid #9c9c9c",
  borderRadius: "0.25rem",
};





const Canvas = () => {
  
  const canvasRef = useRef(null);
  const [Excalidraw, setExcalidraw] = useState(null);
  const excalidrawRef = useRef();
  useEffect(() => {
    import("@excalidraw/excalidraw").then((comp) => setExcalidraw(comp.Excalidraw));
    console.log(Excalidraw)
  }, []);

  const handleExportImage = async () => {
    const files = excalidrawRef.current.getFiles();
    const file = files[0]; // Assuming you want the first file
    console.log(file)
    // Convert the file to a hexadecimal representation
    const reader = new FileReader();
    reader.onloadend = async function(evt) {
      if (evt.target.readyState == FileReader.DONE) {
        const arrayBuffer = evt.target.result;
        const hex = Array.from(new Uint8Array(arrayBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');

        // Send the hexadecimal representation to the image converter API
        const response = await fetch('https://getimg.ai/api/convert', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ image: hex })
        });

        const data = await response.json();
        console.log(data);
      }
    };
    reader.readAsArrayBuffer(file);
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
          <button onClick={handleExportImage}>Export Image</button>
    </div>
  );
};

export default Canvas;