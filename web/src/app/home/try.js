"use client";
import React from "react";
import Logo from "./logo";

import Image from "next/image";
import APIClient from "@/store/apiClient";

function Try() {
  const apiClient = new APIClient();
  const [searchQuery, setSearchQuery] = React.useState("");
  const [data, setData] = React.useState("");
  const [isLoading, setLoading] = React.useState(false);
  const [isError, setError] = React.useState(false);
  const handleSearch = async () => {
    setLoading(true);
    const res = await apiClient.generate(searchQuery);
    if ((res.status = 200)) {
      console.log(res);
      setData(res.image);
    }
    setLoading(false);
  };

  return (
    <div
      className="max-w-6xl p-5 md:py-20 mx-auto flex flex-col items-center"
      data-aos="zoom-y-out"
    >
      <Logo x={1} />
      <h1
        className="text-5xl md:text-4xl font-extrabold leading-tighter tracking-tighter mb-4 text-center"
        data-aos="zoom-y-out"
      >
        Imagine, Inscribe, Innovate
      </h1>

      <div
        class="md:w-[60%] h-fit mx-auto mt-7 flex w-[92%] items-center rounded-full border border-gray-800 hover:shadow-md ring ring-indigo-400 justify-center"
        data-aos="zoom-y-out pb-5"
      >
        <div class="pl-5" data-aos="zoom-y-out">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6 text-gray-400"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z"
            />
          </svg>
        </div>
        <textarea
          placeholder="Write your imagination here. The sky is the limit..."
          type="text"
          class="w-full h-full bg-transparent rounded-full py-[14px] pl-4 outline-none items-center"
          data-aos="zoom-y-out"
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <div
          class="m-5 p-3 hover:cursor-pointer hover:bg-green-500 hover:text-black rounded-full aspect-square flex items-center justify-center resize-none"
          data-aos="zoom-y-out"
          onClick={handleSearch}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6 "
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>
      </div>
      {isLoading && <p>Loading...</p>}
      {data !== "" && (
        <Image
          src={data}
          alt={searchQuery}
          width={200}
          height={200}
          className="w-auto py-10 rounded-xl"
        />
      )}
    </div>
  );
}

export default Try;
