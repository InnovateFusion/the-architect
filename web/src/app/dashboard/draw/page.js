"use client";
import Canvas from "./Board";

export default function Draw() {
  return (
    <div className="w-full h-screen border bg-black flex px-auto items-center justify-around">
      <div className="w-1/3 h-96 border bg-red-300">hi</div>
      <div className="w-96 h-96 border bg-black mx-2.5">
        <Canvas />
      </div>
      <div className="w-1/3 h-96 border bg-purple-400">hi</div>
    </div>
  );
}
