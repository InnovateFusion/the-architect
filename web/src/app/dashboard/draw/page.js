"use client";
import Canvas from "./Board";

export default function Draw() {
  return (
    <div className="w-full h-screen  flex px-auto items-center justify-between">
      <div className="w-96 h-96 border bg-black mx-2.5">
        <Canvas />
      </div>
      <div className="w-96 h-96 border bg-black mx-2.5">
        <Canvas />
      </div>
      <div className="w-96 h-96 border bg-black mx-2.5">
        <Canvas />
      </div>
    </div>
  );
}
