"use client";
import { useEffect, useState } from "react";
import DesignView from "../../designs/DesignView";
import ImageZoom from "react-image-zooom";
import { Capitalize } from "@/utils/utils";
import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";
export default function Design({ params: { id } }) {
  const [design, setDesign] = useState(null);
  const [open, setOpen] = useState(false);
  const handleOpen = () => setOpen(!open);
  const router = useRouter();

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
  useEffect(() => {
    const fetchDesign = async () => {
      const token = localStorage.getItem("token");
      if (!token) {
        toast.error("Invalid Credentials. Please Sign in Again.");
        router.push("/auth/signin");
        return;
      }
      try {
        const response = await fetch(
          `https://the-architect.onrender.com/api/v1/posts/${id}`,
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
          setDesign(result);
        }
      } catch (error) {
        console.error(error);
      }
    };
    fetchDesign();
  }, [id]);

  if (!design) {
    return (
      <div className="bg-gray-100 dark:bg-gray-800 py-8">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row -mx-4">
            <div className="md:flex-1 px-4">
              <div className="h-[460px] rounded-lg bg-gray-300 dark:bg-gray-700 mb-4"></div>
              <div className="flex -mx-2 mb-4">
                <div className="w-1/2 px-2">
                  <div className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold text-center hover:bg-gray-300 dark:hover:bg-gray-600">
                    Variation
                  </div>
                </div>
                <div className="w-1/2 px-2">
                  <div className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold text-center hover:bg-gray-300 dark:hover:bg-gray-600">
                    Modification
                  </div>
                </div>
                <div className="w-1/2 px-2">
                  <div className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold text-center hover:bg-gray-300 dark:hover:bg-gray-600">
                    To 3D
                  </div>
                </div>
              </div>
            </div>
            <div className="md:flex-1 p-4">
              <div className="flex items-center space-x-2 py-3">
                Designer:
                <div className="p-2 rounded-full bg-gray-300 dark:bg-gray-700 w-10 h-10"></div>
                <div className="cursor-pointer font-bold w-20 h-6 bg-gray-300 dark:bg-gray-700"></div>
              </div>
              <div className="flex py-2 justify-between">
                <div className="text-2xl font-bold text-gray-800 dark:text-white mb-2 w-3/4 h-8 bg-gray-300 dark:bg-gray-700"></div>
                <div className="flex space-x-2 px-5">
                  <div className="flex space-x-1 items-center">
                    <span> 1.2k </span>
                    <span> {clone} </span>
                    <span />
                    <span> 362 </span>
                    <span> {view} </span>
                  </div>
                </div>
              </div>
              <div className="text-gray-600 dark:text-gray-300 text-sm mb-4 w-1/2 h-10 bg-gray-300 dark:bg-gray-700"></div>
              <div>
                <div className="font-bold text-gray-700 dark:text-gray-300">
                  Description:
                </div>
                <div className="text-gray-600 dark:text-gray-300 text-sm my-2 w-1/2 h-10 bg-gray-300 dark:bg-gray-700"></div>
              </div>
              <div className="mb-4">
                <div className="font-bold text-gray-700 dark:text-gray-300">
                  Tags:
                </div>
                <div className="flex items-center mt-2">
                  <div className="bg-gray-300 dark:bg-gray-700 text-gray-700 dark:text-white py-2 px-4 rounded-full font-bold mr-2 w-20 h-8"></div>
                  <div className="bg-gray-300 dark:bg-gray-700 text-gray-700 dark:text-white py-2 px-4 rounded-full font-bold mr-2 w-20 h-8"></div>
                  <div className="bg-gray-300 dark:bg-gray-700 text-gray-700 dark:text-white py-2 px-4 rounded-full font-bold mr-2 w-20 h-8"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-gray-100 dark:bg-gray-800 py-8">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row -mx-4">
          <div className="md:flex-1 px-4">
            <div className="h-[460px] rounded-lg bg-gray-300 dark:bg-gray-700 mb-4">
              <Image
                className="w-full h-full object-cover hover:cursor-pointer"
                src={design?.image}
                alt={design?.title}
                width={512}
                height={512}
                onClick={handleOpen}
                priority
              />
            </div>
            <div className="flex -mx-2 mb-4">
              <div className="w-1/2 px-2">
                <button className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold hover:bg-gray-300 dark:hover:bg-gray-600">
                  Variation
                </button>
              </div>
              <div className="w-1/2 px-2">
                <button className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold hover:bg-gray-300 dark:hover:bg-gray-600">
                  Modification
                </button>
              </div>
              <div className="w-1/2 px-2">
                <button className="w-full bg-gray-200 dark:bg-gray-700 text-gray-800 dark:text-white py-2 px-4 rounded-full font-bold hover:bg-gray-300 dark:hover:bg-gray-600">
                  To 3D
                </button>
              </div>
            </div>
          </div>
          <div className="md:flex-1 p-4">
            <div className="flex items-center space-x-2 py-3">
              Designer:{" "}
              <Image
                width={40}
                height={40}
                className="p-2 rounded-full "
                src={design?.userImage}
                alt="logo"
              />
              <Link href={`/dashboard/profile/${design?.userId}`}>
                <h2 className="font-bold cursor-pointer">
                  {Capitalize(design?.firstName)} {Capitalize(design?.lastName)}
                </h2>
              </Link>
            </div>
            <div className="flex py-2 justify-between">
              <h2 className="text-2xl font-bold text-gray-800 dark:text-white mb-2">
                {design?.title}
              </h2>

              <div className="flex space-x-2  px-5">
                <div className="flex space-x-1 items-center">
                  <span> {design?.clone} </span>
                  <span> {clone} </span>
                  <span />
                  <span> {design?.like} </span>
                  <span> {view} </span>
                </div>
              </div>
            </div>
            <div>
              <span className="font-bold text-gray-700 dark:text-gray-300">
                Description:
              </span>
              <p className="text-gray-600 dark:text-gray-300 text-sm my-2">
                {design?.content}
              </p>
            </div>
            <div className="mb-4">
              <span className="font-bold text-gray-700 dark:text-gray-300">
                Tags:
              </span>
              <div className="flex flex-wrap items-center mt-2 gap-3">
                {design?.tags.map((tag, index) => (
                  <button
                    key={index}
                    className="bg-gray-300 dark:bg-gray-700 text-gray-700 dark:text-white py-2 px-4 rounded-full font-bold mr-2 hover:bg-gray-400 dark:hover:bg-gray-600"
                  >
                    {tag}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
      <DesignView open={open} handleOpen={handleOpen}>
        <ImageZoom zoom="300" src={design?.image} alt="" />
      </DesignView>
    </div>
  );
}
