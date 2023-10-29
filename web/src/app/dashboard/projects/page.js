"use client";
import { Icons } from "@/utils/icons";
import { Button } from "@material-tailwind/react";
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
    if (res.status == 200) {
      const posts = await res.json();
    }
    router.refresh("/dashboard/projects");
  };
  useEffect(() => {
    const fetchUser = async () => {
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
          console.log(result[0]);
        }
      } catch (error) {
        console.error(error);
      }
    };
    fetchUser();
  }, []);

  const Iconss = Icons["plus"];
  return (
    <div className="flex flex-row p-3 gap-3 h-[100%]">
      <div
        className={`w-${size} w- p-5 bg-gray-3 border border-gray-2  rounded-lg sticky top-0 overflow-auto`}
      >
        <div className="flex flex-col gap-2 justify-around">
          <div className="flex w-full justify-center">
            <button
              onClick={(e) => {
                setSize("2/5");
                router.push(`/dashboard/edit`);
                setChat("");
              }}
              variant="gradient"
              color="indigo"
              className="flex gap-2 btn btn-primary bg-blue-gray-700 hover:bg-blue-gray-900 duration-100"
            >
              <Iconss size={20} />
              Create New Project
            </button>
          </div>
          {!chats && <Loader />}
          {chats?.map((chat, i) => {
            const Icon = Icons["link"];
            return (
              <div
                className="flex w-full items-center space-x-2 p-2 cursor-pointer hover:bg-gray-200 hover:border-r-8 dark:hover:bg-gray-700 overflow-x-hidden"
                key={chat.id}
                onClick={(e) => {
                  setSize("2/5");
                  // router.push(`/dashboard/edit?chatId=${chat.id}`);
                  setChat(chat);
                }}
              >
                <span>
                  <Icon size={20} />
                </span>
                <span className="whitespace-nowrap overflow-x-hidden">
                  {Capitalize(chat.title || "Title")}...
                </span>
              </div>
            );
          })}
        </div>
      </div>
      <Chat2 size={size} chat={chat} handleDelete={handleDelete} />
    </div>
  );
}

export default Projects;
