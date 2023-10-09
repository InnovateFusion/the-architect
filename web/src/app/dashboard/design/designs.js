import Image from "next/image";
import Link from "next/link";
import React, { useState } from "react";

function DesignList() {
  const images = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  return (
    <div className="mx-auto px-4 py-16 sm:px-6 sm:py-16 lg:px-8">
      <div className="flex flex-wrap md:-m-2">
        <div className="w-full lg:w-1/2 p-2">
          <div className={`card image-full opacity-100`}>
            <figure>
              <Image
                height={1000}
                width={1000}
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
                    <Link href="/dashboard/edit">
                      <Image
                        width={20}
                        height={20}
                        alt="author"
                        src="/clone.png"
                      />
                    </Link>
                  </span>
                  <span className="text-gray-400"> | </span>
                  3.5k <span className="text-gray-100"> views</span>
                </div>
                <Link
                  className="btn btn-neutral btn-circle"
                  href="/dashboard/edit"
                >
                  <Image width={20} height={20} alt="author" src="/clone.png" />
                </Link>
              </div>
            </div>
          </div>
        </div>

        <div className="w-full lg:w-1/2 flex flex-wrap">
          {images.slice(1, 5).map((item, index) => {
            return (
              <div className="w-full md:w-1/2 p-2" key={index}>
                <div className={`card image-full opacity-100`}>
                  <figure>
                    <Image
                      height={1000}
                      width={1000}
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
                      <Link
                        className="btn btn-neutral btn-circle"
                        href="/dashboard/edit"
                      >
                        <Image
                          width={20}
                          height={20}
                          alt="author"
                          src="/clone.png"
                        />
                      </Link>
                    </div>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
      <div className=" flex flex-wrap md:-m-2">
        <div className="flex w-full flex-wrap">
          {images.slice(5).map((item, index) => {
            return (
              <div
                className={`card w-full md:w-1/2 lg:w-1/4 p-1 md:p-2  image-full opacity-100`}
                key={index}
              >
                <figure>
                  <Image
                    height={200}
                    width={200}
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
                    <Link
                      className="btn btn-neutral btn-circle"
                      href="/dashboard/edit"
                    >
                      <Image
                        width={20}
                        height={20}
                        alt="author"
                        src="/clone.png"
                      />
                    </Link>
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
