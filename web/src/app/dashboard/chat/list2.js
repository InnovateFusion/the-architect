import Image from "next/image";
import React, { useState } from "react";

function List() {
  const images = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  return (
    <div class="container mx-auto px-5 py-2 lg:px-32 lg:pt-24">
      <div class="-m-1 flex flex-wrap md:-m-2">
        <div class="flex w-full flex-wrap">
          {images.map((item, index) => {
            return (
              <div
                class={`card md:w-1/2 sm:w-full lg:w-${
                  index == 0 || index == 4 || index == 4 || index == 4
                    ? "1/2"
                    : "1/4"
                } p-1 md:p-2  image-full opacity-100`}
                key={index}
              >
                <figure>
                  <Image
                    height={2000}
                    width={2000}
                    alt="gallery"
                    class="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
                    src="https://tecdn.b-cdn.net/img/Photos/Horizontal/Nature/4-col/img%20(70).webp"
                  />
                </figure>
                <div className="card-body">
                  <p>
                    <div className="avatar">
                      {/* slide and show name on hover */}
                      <div className="w-14 rounded-full ring p-3 bg-white border-2 border-white">
                        <Image
                          width={40}
                          height={40}
                          alt="author"
                          src="/logo.svg"
                        />
                      </div>
                    </div>
                  </p>
                  <div className="card-actions justify-between flex gap-2 align-bottom">
                    <div className="flex gap-2 align-center justify-center">
                      2.7k{" "}
                      <span className="text-gray-400">
                        <Image
                          width={20}
                          height={20}
                          alt="author"
                          src="/clone.png"
                        />
                      </span>
                      <span className="text-gray-400"> | </span>
                      3.5k <span className="text-gray-100"> views</span>
                    </div>
                    <button className="btn btn-neutral btn-circle">
                      <Image
                        width={20}
                        height={20}
                        alt="author"
                        src="/clone.png"
                      />
                    </button>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export default List;
