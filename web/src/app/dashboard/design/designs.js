import Image from "next/image";
import Link from "next/link";
import React, { useEffect, useState } from "react";

function DesignList() {
  const [posts, setPosts] = useState([]);
  const images = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  const view = (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      strokeWidth={1.5}
      stroke="currentColor"
      className="w-6 h-6"
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"
      />
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
      />
    </svg>
  );

  const clone = (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      strokeWidth={1.5}
      stroke="currentColor"
      className="w-6 h-6"
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75"
      />
    </svg>
  );

  const getPosts = async () => {
    const res = await fetch(
      "https://the-architect.onrender.com/api/v1/posts/all",
      {
        method: "GET",
      }
    );
    const newPosts = await res.json();
    setPosts([...newPosts, ...posts]);
    console.log(posts);
  };

  useEffect(() => {
    getPosts();
  }, []);

  return (
    <div className="columns-1 sm:columns-2 md:columns-2 lg:columns-3 gap-4 space-y-4 py-14 px-2">
      {posts.length > 0
        ? posts.map((item) => (
            <div className="rounded-lg overflow-hidden mb-8" key={item.id}>
              <Image src={item.image} alt={item.id} width={512} height={512} />
            </div>
          ))
        : images.map((item, index) => (
            <div
              key={index}
              className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none "
            >
              <div className="h-full w-full rounded-xl bg-gray-100 animate-pulse"></div>
            </div>
          ))}
    </div>
  );
}

export default DesignList;
