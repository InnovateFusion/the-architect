"use client";
import { Icons } from "@/utils/icons";
import Link from "next/link";
import { useRouter } from "next/navigation";
import React, { useEffect, useState } from "react";
import Chat2 from "./chat";
import Loader from "@/components/Loader";
import { Capitalize } from "@/utils/utils";
import { toast } from "react-toastify";

function Projects() {
  const [size, setSize] = useState("2/5");
  const [chats, setChats] = useState(null);
  const [chat, setChat] = useState("");
  const router = useRouter();
  const handleDelete = async (id) => {
    setChats(chats.filter((i) => i.id != id));
    setChat("");
    const token = localStorage.getItem("token");
    if (!token) {
      toast.error("Invalid Credentials. Please Sign in Again.");
      router.push("/auth/signin");
      return;
    }
    const url = `https://the-architect.onrender.com/api/v1/chats/${chat.id}`;
    const res = fetch(url, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    toast.success("Project Chat Successfully Deleted.");
    router.refresh("/dashboard/projects");
  };
  useEffect(() => {
    const fetchUserChat = async () => {
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId");
      try {
        const response = await fetch(
          `https://the-architect.onrender.com/api/v1/users/${userId}/chats`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        );

        if (response.status == 200) {
          const result = await response.json();
          setChats(result);
        } else {
          toast.error("Failed to Load Your Projects.");
        }
      } catch (error) {
        console.error(error);
        toast.error("Unable to Load Your Projects.");
      }
    };
    fetchUserChat();
  }, []);

  const Iconss = Icons["plus"];
  return (
    <div className="flex md:flex-row flex-col p-3 gap-3 h-[100%]">
      <div
        className={`max-w-sm min-h-[40%] md:h-[100%] p-5 bg-gray-3 border border-gray-2  rounded-lg sticky top-0 overflow-auto`}
      >
        <div className="flex flex-col gap-2 justify-around">
          <div className="flex sticky w-full justify-center">
            <button
              onClick={(e) => {
                router.push(`/dashboard/tools`);
                setChat("");
              }}
              variant="gradient"
              color="indigo"
              className="flex gap-2 btn btn-primary p-3 bg-green-600 dark:bg-green-600 hover:bg-green-600 dark:hover:bg-green-500 duration-100"
            >
              <Iconss size={20} />
              Create New Project
            </button>
          </div>
          {!chats && <Loader />}
          {chats?.map((chatItem, i) => {
            const Icon = Icons["link"];
            return (
              <div
                className={`flex m-w-sm items-center space-x-2 p-2 cursor-pointer hover:bg-gray-300 hover:border-r-8 border-gray-500 dark:hover:bg-gray-700 overflow-x-hidden ${
                  chat.id == chatItem.id &&
                  "dark:bg-gray-700 bg-gray-300 border-r-8 border-gray-500"
                }`}
                key={chatItem.id}
                onClick={(e) => {
                  setSize("2/5");
                  // router.push(`/dashboard/edit?chatId=${chat.id}`);
                  setChat(chatItem);
                }}
              >
                <span>
                  <Icon size={20} />
                </span>
                <span className="whitespace-nowrap overflow-x-hidden">
                  {Capitalize(chatItem.title || "Title")}...
                </span>
              </div>
            );
          })}
        </div>
      </div>
      {chat ? (
        <Chat2 size={size} chat={chat} handleDelete={handleDelete} />
      ) : (
        ""
      )}
    </div>
  );
}

export default Projects;
