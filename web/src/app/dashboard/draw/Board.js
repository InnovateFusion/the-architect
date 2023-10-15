"use client";
import React, { useRef } from "react";
import { useState, useEffect } from "react";

const styles = {
  border: "0.0625rem solid #9c9c9c",
  borderRadius: "0.25rem",
};

const Canvas = () => {
  const canvasRef = useRef(null);
  const [Excalidraw, setExcalidraw] = useState(null);
  const [canvasUrl, setCanvasUrl] = useState("");
  const [excalidrawAPI, setExcalidrawAPI] = useState(null);

  const excalidrawRef = useRef();
  useEffect(() => {
    import("@excalidraw/excalidraw").then((comp) =>
      setExcalidraw(comp.Excalidraw)
    );
    console.log(Excalidraw);
  }, []);


  return (
    <div className="h-600 aspect-square p-4">
      {Excalidraw && (
        <Excalidraw
          UIOptions={{
            canvasActions: {
              toggleTheme: false,
              changeViewBackgroundColor: false,
              loadScene: false,
              // saveAsImage: false,
              export: false,
              changeViewBackgroundColor: false,
            },
          }}
          ref={(api) => setExcalidrawAPI(api)}
          width={600}
          height={"100vh"}
          initialData={{
            elements: [],
            appState: {},
          }}
        />
      )}
      {/* <button onClick={handleExport}>Export Image</button> */}
    </div>
  );
};

export default Canvas;
