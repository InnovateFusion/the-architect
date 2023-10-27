"use client";

import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import Image from "next/image";
import Loader from "@/components/Loader";

const DesignView = ({ params }) => {
  const router = useRouter();
  const { id } = params;
  const [design, setDesign] = useState(null);

  useEffect(() => {
    const fetchDesign = async () => {
      const token = localStorage.getItem("token");
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
      <Loader />
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <Image
            src={design.image}
            alt={design.title}
            width={512}
            height={512}
            className="w-full h-auto"
          />
        </div>
        <div>
          <h1 className="text-3xl font-bold mb-4">{design.title}</h1>
          <p className="text-gray-600 mb-4">{design.content}</p>
          <div className="flex items-center mb-4">
            <Image
              src={`/house.jpg`}
              alt={design.firstName}
              width={40}
              height={40}
              className="rounded-full mr-2"
            />
            <span>{`${design.firstName} ${design.lastName}`}</span>
          </div>
          <div className="flex items-center mb-4">
            <span className="mr-2">{design.date}</span>
            <span className="mr-2">{`${design.like} Likes`}</span>
            <span>{`${design.clone} Clones`}</span>
          </div>
          <div className="flex flex-wrap">
            {design.tags.map((tag) => (
              <span
                key={tag}
                className="bg-gray-200 text-gray-600 rounded-full px-3 py-1 text-sm font-semibold mr-2 mb-2"
              >
                {tag}
              </span>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default DesignView;
