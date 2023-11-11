"use client";
import React, { useEffect } from "react";
import Logo from "./logo";

import Image from "next/image";
import ImageZoom from "react-image-zooom";
import APIClient from "@/store/apiClient";
import { toast } from "react-toastify";
import { prompts } from "@/utils/constant";
function Try() {
  const apiClient = new APIClient();
  const [searchQuery, setSearchQuery] = React.useState("");
  const [data, setData] = React.useState("/house.jpg");
  const [isLoading, setLoading] = React.useState(false);
  const [isError, setError] = React.useState(false);

  const handleSuggestion = () => {
    const rand = Math.floor(Math.random() * prompts.length);
    console.log(prompts[rand]);
    setSearchQuery(prompts[rand]);
  };
  const handleSearch = async () => {
    if (searchQuery == "") return;
    setLoading(true);
    const res = await apiClient.generate(searchQuery);
    if (res.image) {
      console.log(res);
      setData(res.image);
    } else {
      toast.error("Connection Problem, Please, Try again.");
    }
    setLoading(false);
  };

  useEffect((e) => {});

  return (
    <div
      className="max-w-6xl p-5 md:py-20 mx-auto flex flex-col items-center gap-5"
      data-aos="zoom-y-out"
    >
      <Logo x={1} />
      <h1
        className="text-4xl md:text-5xl leading-tighter tracking-tighter mb-4 text-center font-gagalin"
        data-aos="zoom-y-out"
      >
        Imagine, Inscribe, Innovate
      </h1>

      <div
        className="md:w-[60%] h-fit mx-auto flex w-[92%] items-center rounded-full border border-gray-800 hover:shadow-md ring ring-indigo-400 justify-center"
        data-aos="zoom-y-out"
      >
        <button
          className="m-3 p-3 hover:cursor-pointer"
          data-aos="zoom-y-out"
          onClick={handleSuggestion}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            className="lucide lucide-dices"
          >
            <rect width="12" height="12" x="2" y="10" rx="2" ry="2" />
            <path d="m17.92 14 3.5-3.5a2.24 2.24 0 0 0 0-3l-5-4.92a2.24 2.24 0 0 0-3 0L10 6" />
            <path d="M6 18h.01" />
            <path d="M10 14h.01" />
            <path d="M15 6h.01" />
            <path d="M18 9h.01" />
          </svg>
        </button>
        <textarea
          placeholder="Write your design imagination here. The sky is the limit..."
          type="text"
          className="w-full h-full bg-transparent rounded-full py-[14px] pl-4 outline-none items-center pb-10"
          data-aos="zoom-y-out"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        {
          // searchQuery == "" ? (
          //   <div
          //     className="m-5 p-3 hover:cursor-pointer bg-blue-500 duration-100 hover:text-white rounded-full aspect-square flex items-center justify-center resize-none"
          //     data-aos="zoom-y-out"
          //   >
          //     <svg
          //       xmlns="http://www.w3.org/2000/svg"
          //       className="h-6 w-6"
          //       fill="none"
          //       viewBox="0 0 24 24"
          //       stroke="currentColor"
          //       strokeWidth="2"
          //     >
          //       <path
          //         strokeLinecap="round"
          //         strokeLinejoin="round"
          //         d="M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z"
          //       />
          //     </svg>
          //   </div>
          // ) : (
          <div
            className="m-5 p-3 hover:cursor-pointer bg-blue-500 hover:bg-green-500 hover:m-3 hover:p-5 hover:text-white rounded-full aspect-square flex items-center justify-center resize-none"
            data-aos="zoom-y-out"
            onClick={handleSearch}
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              className="lucide lucide-sparkles"
            >
              <path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z" />
              <path d="M5 3v4" />
              <path d="M19 17v4" />
              <path d="M3 5h4" />
              <path d="M17 19h4" />
            </svg>
          </div>
        }
      </div>
      {isLoading && <p>Loading...</p>}
      {data && (
        <ImageZoom
          zoom="300"
          src={data}
          alt={searchQuery}
          width={400}
          height={400}
          className="rounded-xl"
        />
      )}
    </div>
  );
}

export default Try;
