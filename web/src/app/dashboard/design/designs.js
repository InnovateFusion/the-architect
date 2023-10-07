import Image from "next/image";
import React, { useState } from "react";

function DesignList() {
  const images = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  return (
    <div className="container mx-auto px-5 py-2 lg:px-2 lg:pt-14">
      <div className="flex flex-wrap">
        <div className="w-full md:w-1/2 p-2">
          <div className={`card image-full opacity-100`}>
            <figure>
              <Image
                height={2000}
                width={2000}
                alt="gallery"
                className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
                src="/house.jpg"
              />
            </figure>
            <div className="card-body">
              <div className="avatar w-10">
                <div className="rounded-full ring p-2 bg-slate-300 border-1 border-collapse">
                  <Image width={40} height={40} alt="author" src="/logo.svg" />
                </div>
              </div>
              <p></p>
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
                  <Image width={20} height={20} alt="author" src="/clone.png" />
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="w-full md:w-1/2 flex flex-wrap">
          <div className="w-full md:w-1/2 p-2">
            <div className={`card image-full opacity-100`}>
              <figure>
                <Image
                  height={2000}
                  width={2000}
                  alt="gallery"
                  className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
                  src="/house.jpg"
                />
              </figure>
              <div className="card-body">
                <div className="avatar w-10">
                  <div className="rounded-full ring p-2 bg-slate-300 border-1 border-collapse">
                    <Image
                      width={40}
                      height={40}
                      alt="author"
                      src="/logo.svg"
                    />
                  </div>
                </div>
                <p></p>
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
          </div>
          <div className="w-full md:w-1/2 p-2">
            <Image
              height={2000}
              width={2000}
              alt="gallery"
              className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
              src="/house.jpg"
            />
          </div>
          <div className="w-full md:w-1/2 p-2">
            <Image
              height={2000}
              width={2000}
              alt="gallery"
              className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
              src="/house.jpg"
            />
          </div>
          <div className="w-full md:w-1/2 p-2">
            <div className={`card image-full opacity-100`}>
              <figure>
                <Image
                  height={2000}
                  width={2000}
                  alt="gallery"
                  className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
                  src="/house.jpg"
                />
              </figure>
              <div className="card-body">
                <div className="avatar w-10">
                  <div className="rounded-full ring p-2 bg-slate-300 border-1 border-collapse">
                    <Image
                      width={40}
                      height={40}
                      alt="author"
                      src="/logo.svg"
                    />
                  </div>
                </div>
                <p></p>
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
          </div>
        </div>
      </div>

      <br />

      <div className=" flex flex-wrap md:-m-2">
        <div className="flex w-full flex-wrap">
          {images.map((item, index) => {
            return (
              <div
                className={`card w-1/2 sm:w-full md:w-1/4 p-1 md:p-2  image-full opacity-100`}
                key={index}
              >
                <figure>
                  <Image
                    height={2000}
                    width={2000}
                    alt="gallery"
                    className="block h-full w-full rounded-lg object-cover object-center z-10 opacity-70"
                    src="/house.jpg"
                  />
                </figure>
                <div className="card-body">
                  <div className="avatar w-10">
                    <div className="rounded-full ring p-2 bg-white border-1 border-collapse">
                      <Image
                        width={40}
                        height={40}
                        alt="author"
                        src="/logo.svg"
                      />
                    </div>
                  </div>
                  <p></p>
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

export default DesignList;
