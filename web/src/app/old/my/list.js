"use client";
import Image from "next/image";
import React, { useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { toast } from "react-toastify";
function List() {
  const [data, setData] = useState([]);
  const router = useRouter();

  const getPosts = async () => {
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");
    if (!token) {
      toast.error("Invalid Credentials. Please Sign in Again.");
      router.push("/auth/signin");
      return;
    }

    const url = `https://the-architect.onrender.com/api/v1/users/${userId}/posts`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    const posts = await res.json();
    setData(posts);
    console.log(posts);
  };
  useEffect(() => {
    getPosts();
  }, []);

  return (
    <div>
      <div className="">
        <div className="mx-auto px-4 py-16 sm:px-6 sm:py-6 lg:px-8">
          <h2 className="text-2xl font-bold tracking-tight ">My Designs</h2>
          <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 py-6 px-2">
            {data.length > 0
              ? data.map((item, index) => (
                  <div className="group relative" key={item.id}>
                    <div
                      className={`aspectw-${
                        index % 2 == 0 ? "full" : "1/2"
                      } overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80`}
                    >
                      <Link href={`/dashboard/design/${item.id}`}>
                        <Image
                          width={2000}
                          height={2000}
                          src={item.image}
                          alt="Front of men&#039;s Basic Tee in black."
                          className="h-full w-full object-cover object-center lg:h-full lg:w-full"
                        />
                      </Link>
                    </div>
                  </div>
                ))
              : [1, 2, 3, 4, 5, 6, 7, 8].map((item, index) => (
                  <div
                    key={index}
                    className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none "
                  >
                    <div className="h-full w-full rounded-xl bg-gray-100 animate-pulse"></div>
                  </div>
                ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default List;
