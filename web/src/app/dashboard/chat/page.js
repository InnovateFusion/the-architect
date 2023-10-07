"use client"
import Image from "next/image";
import Chat from "./chat";
import List from "./list2";

export default function Page() {
  return (
    <div>
      <button
        className="btn"
        onClick={() => {
          document.getElementById("my_modal_1").showModal();
        }}
      >
        open modal
      </button>
      <dialog id="my_modal_1" className="modal max-w-md overflow-y-scroll">
        <Chat />
      </dialog>
      <List />
    </div>
  );
}
