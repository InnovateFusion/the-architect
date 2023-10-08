"use client";

import * as React from "react";
import { ReactSketchCanvas } from "react-sketch-canvas";
const styles = {
  border: "0.0625rem solid #9c9c9c",
  borderRadius: "0.25rem",
};

export default function Canvas() {
  const canvasRef = React.useRef(null);

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
    } else {
      console.log("else");
    }
  };
  return (
    <div className="w-96 h-96">
      <ReactSketchCanvas style={styles} strokeWidth={4} strokeColor="black" />
      {/* <button onClick={handleExportImage}>Get Image</button> */}
    </div>
  );
}
