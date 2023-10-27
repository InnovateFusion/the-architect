"use client";
import { useEffect, useState } from "react";
import Image from "next/image";
import { Capitalize } from "@/utils/utils";
import PostCard from "../designs/PostCard";

export default function Profile() {
  const [posts, setPosts] = useState(null);
  const [open, setOpen] = useState(false);
  const handleOpen = () => setOpen(!open);
  const [user, setUser] = useState(null);

  useEffect(() => {
    const fetchUser = async () => {
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId");
      try {
        const response = await fetch(
          `https://the-architect.onrender.com/api/v1/users/${userId}`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        );

        if (response.ok) {
          const result = await response.json();
          setUser(result);
          console.log(result);
        }
      } catch (error) {
        console.error(error);
      }
    };
    fetchUser();
    const fetchPosts = async () => {
      const token = localStorage.getItem("token");
      try {
        const response = await fetch(
          `https://the-architect.onrender.com/api/v1/users/${userId}/posts`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        );

        if (response.ok) {
          const result = await response.json();
          setPosts(result);
          console.log(result);
        }
      } catch (error) {
        console.error(error);
      }
    };
    fetchPosts();
  }, []);

  if (!user) {
    return (
      <div className="bg-gray-100 dark:bg-gray-800 py-8">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex max-h-[450px] flex-col md:flex-row -mx-4 bg-gray-3 border border-gray-2    rounded-xl m-4 px-2 overflow-y-auto">
            <div className="md:flex-1 pt-4 flex gap-2 m-4">
              <div className="w-[50%] aspect-square rounded-lg -700 mb-4">
                <div className="aspect-square rounded-full hover:cursor-pointer bg-gray-300"></div>
              </div>
              <div className="w-[50%] aspect-square rounded-lg m-4 align-center justify-center">
                <div className="flex flex-col space-r-2">
                  <h4 className="text-3xl font-bold cursor-pointer w-48 h-8 bg-gray-300"></h4>
                  <span>Interior Designer</span>
                </div>
                <div className="flex pt-4 space-x-2">
                  <span>Email:</span>
                  <h2 className="font-bold text-gray-800 dark:text-white mb-2 w-48 h-8 bg-gray-300"></h2>
                </div>
                <div className="flex py-1 space-x-2">
                  <span>Country:</span>
                  <h2 className="font-bold text-gray-800 dark:text-white mb-2 w-48 h-8 bg-gray-300"></h2>
                </div>
                <div className="flex space-x-2 pt-4 gap-5">
                  <div className="flex flex-col items-center">
                    <span className="text-2xl w-20 h-8 bg-gray-300"></span>
                    <span className="font-bold w-20 h-6 bg-gray-300"></span>
                  </div>
                  <div className="flex flex-col items-center">
                    <span className="text-2xl w-20 h-8 bg-gray-300"></span>
                    <span className="font-bold w-20 h-6 bg-gray-300"></span>
                  </div>
                </div>
              </div>
            </div>
            <div className="md:flex-1 px-10 md:p-16 gap-2">
              <span>Bio:</span>
              <br />
              <div className="flex py-1 space-x-2">
                <h2 className="font-bold text-gray-800 dark:text-white mb-2 w-48 h-8 bg-gray-300"></h2>
              </div>
            </div>
          </div>
          <div className="md:flex-1 columns-2 sm:columns-2 md:columns-3 lg:columns-4 gap-3 space-y-4 p-4 justify-center bg-gray-3 border border-gray-2    rounded-xl">
            {[1, 2, 3, 4, 5, 6, 7, 8].map((item, index) => (
              <div
                key={index}
                className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none"
              >
                <div className="h-full w-full rounded-xl dark:bg-gray-100 bg-gray-300 animate-pulse"></div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
  return (
    <div className="bg-gray-100 dark:bg-gray-800 py-8">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex max-h-[450px] flex-col md:flex-row -mx-4 bg-gray-3 border border-gray-2    rounded-xl m-4 px-2 overflow-y-auto">
          <div className="md:flex-1 pt-4 flex gap-2  m-4">
            <div className="w-[50%] aspect-square rounded-lg -700 mb-4 ">
              <Image
                className="aspect-square rounded-full hover:cursor-pointer "
                src={user.image || "/house.jpg"}
                alt={user.firstName}
                width={512}
                height={512}
                onClick={handleOpen}
              />
            </div>
            <div className="w-[50%] aspect-square rounded-lg m-4 aligh-center justify-center">
              <div className="flex flex-col space-r-2 ">
                <h4 className="text-3xl font-bold cursor-pointer">
                  {Capitalize(user.firstName)} {Capitalize(user.lastName)}
                </h4>
                <span>Interior Designer </span>
              </div>
              <div className="flex pt-4 space-x-2">
                <span>Email: </span>
                <h2 className="font-bold text-gray-800 dark:text-white mb-2">
                  {user.email}
                </h2>
              </div>

              <div className="flex py-1 space-x-2">
                <span>Country: </span>
                <h2 className="font-bold text-gray-800 dark:text-white mb-2">
                  {Capitalize(user.country)}
                </h2>
              </div>

              <div className="flex space-x-2 pt-4 gap-5 ">
                <div className="flex flex-col items-center">
                  <span className="text-2xl"> {user?.followers} </span>
                  <span className="font-bold"> followers </span>
                </div>
                <div className="flex flex-col items-center">
                  <span className="text-2xl"> {user?.following} </span>
                  <span className="font-bold"> following </span>
                </div>
              </div>
            </div>
          </div>
          <div className="md:flex-1 px-10 md:p-16 gap-2">
            <span>Bio: </span>
            <br />
            <div className="flex py-1 space-x-2 ">
              <h2 className="font-bold text-gray-800 dark:text-white mb-2 ">
                {user?.bio}
              </h2>
            </div>
          </div>
        </div>
        <div className="md:flex-1 columns-2 sm:columns-2 md:columns-3 lg:columns-4 gap-3 space-y-4 p-4 justify-center bg-gray-3 border border-gray-2    rounded-xl">
          {!posts
            ? [1, 2, 3, 4, 5, 6, 7, 8].map((item, index) => (
                <div
                  key={index}
                  className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none "
                >
                  <div className="h-full w-full rounded-xl dark:bg-gray-100 bg-gray-300 animate-pulse"></div>
                </div>
              ))
            : posts.map((post) => <PostCard key={post.id} post={post} />)}
        </div>
      </div>
    </div>
  );
}
