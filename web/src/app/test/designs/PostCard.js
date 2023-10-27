import React from "react";
import Link from "next/link";
import Image from "next/image";

const view = (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    fill="none"
    viewBox="0 0 24 24"
    strokeWidth={1.5}
    stroke="currentColor"
    className="h-7 w-7 transition duration-100 cursor-pointer"
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
    className="h-7 w-7 transition duration-100 cursor-pointer"
  >
    <path
      strokeLinecap="round"
      strokeLinejoin="round"
      d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75"
    />
  </svg>
);

function DesignCard({ post }) {
  function Capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
  }
  return (
    <>
      <div className="border-2 dark:border-gray-600 border-gray-300 max-w-xs container  rounded-xl shadow-2xl transform transition duration-500 hover:scale-105 hover:shadow-2xl">
        <Link href={{ pathname: `/test/design/${post.id}` }}>
          <Image
            className="w-full cursor-pointer rounded-t-xl"
            src={post.image}
            width={512}
            height={512}
            alt=""
            priority
          />
        </Link>
        <div className="flex p-2 justify-between">
          <div className="flex items-center space-x-2">
            <Image
              className="p-2 aspect-square rounded-full"
              src={post.userImage}
              width={40}
              height={40}
              alt={post?.firstName}
              priority
            />
            <Link href={`/test/profile/${post.userId}`}>
              <h2 className="font-bold cursor-pointer">
                {Capitalize(post.firstName)} {Capitalize(post.lastName)}
              </h2>
            </Link>
          </div>
          <div className="flex space-x-2">
            <div className="flex space-x-1 items-center">
              <span>{clone}</span>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

export default DesignCard;
