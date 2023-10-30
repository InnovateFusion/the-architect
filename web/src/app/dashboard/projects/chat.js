import React, { useState } from "react";
import ChatBuble from "../edit/chatBuble";
import { usePathname, useRouter } from "next/navigation";
import { PostDesign } from "../edit/PostDesign";
import { Capitalize, cn } from "@/utils/utils";
import { LucideExternalLink, Trash } from "lucide-react";
import Modal from "../designs/DesignView";

function Chat2({ size, chat, handleDelete }) {
  const router = useRouter();
  const pathname = usePathname();
  const [open, setOpen] = useState(false);
  const [image, setImage] = useState("/house.jpg");

  const handleOpen = (image) => {
    setOpen(!open);
    if (!open) {
      setImage(image);
    }
  };
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div
      className={`w-${
        size == "full" ? "0 hidden" : "full"
      }  bg-gray-3 border border-gray-2  rounded-lg sticky bottom-0 overflow-auto`}
    >
      <div className="p-2 sticky top-0 z-10 flex justify-between bg-gray-3 border border-gray-2  rounded-tr-lg items-center">
        <b className="whitespace-nowrap overflow-hidden">
          {Capitalize(chat.title || "  ")}
        </b>
        <div className="flex gap-x-2">
          {chat?.id && (
            <button
              onClick={(e) =>
                router.push(
                  `/dashboard/tools?model=image_to_image&chatId=${chat.id}`
                )
              }
              className="w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2 hover:bg-green-600"
            >
              <LucideExternalLink />
            </button>
          )}
          {chat && (
            <button
              onClick={(e) => setIsOpen(true)}
              className={cn(
                "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2 hover:bg-red-600",
                pathname === "/dashboard/profile" ? "bg-gray-2" : ""
              )}
            >
              <Trash size={40} />
            </button>
          )}
        </div>
      </div>
      <div className="overflow-auto p-3">
        {chat?.messages?.map((m, i) => {
          return (
            <ChatBuble
              m={m}
              key={i}
              handleOpen={handleOpen}
              setImage={setImage}
            />
          );
        })}
        <PostDesign open={open} handleOpen={handleOpen} image={image} />
        <ConfirmDelete
          isOpen={isOpen}
          setIsOpen={setIsOpen}
          handleDelete={(e) => handleDelete(chat.id)}
        />
      </div>
    </div>
  );
}

export default Chat2;

const ConfirmDelete = ({ isOpen, setIsOpen, handleDelete }) => (
  <Modal open={isOpen} handleOpen={() => setIsOpen(false)} size={"lg"}>
    <p className="p-6">
      Are you sure you want to delete this Project? <br />
      All of chat messages will be permanently removed. <br /> This action
      cannot be undone.
    </p>
    <div className="flex justify-between">
      <button
        className="rounded-md bg-red-600 px-4 py-2 text-sm font-medium text-white hover:bg-black/30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75"
        onClick={(e) => {
          handleDelete();
          setIsOpen(false);
        }}
      >
        Delete Chat
      </button>
      <button
        className="rounded-md bg-black/20 px-4 py-2 text-sm font-medium text-white hover:bg-black/30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white/75"
        onClick={() => setIsOpen(false)}
      >
        Cancel
      </button>
    </div>
  </Modal>
);
