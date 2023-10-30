"use client";
import Image from "next/image";
import React, { useEffect, useState } from "react";
import Link from "next/link";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import Skeleton from "../designs/PostSkeleton";
import { Info } from "lucide-react";
import { usePosts } from "@/lib/requests";
function List() {
  const router = useRouter();
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);

  const getPosts = async () => {
    setLoading(true);
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
    setLoading(false);
  };

  useEffect(() => {
    getPosts();
  }, []);

  if (!loading && data?.length == 0) {
    return <div className="text-center p-10">No Posts Yet</div>;
  }

  return (
    <div>
      <div className="">
        <div className="mx-auto px-4 py-16 sm:px-6 sm:py-6 lg:px-8">
          <h2 className="text-2xl font-bold tracking-tight ">My Designs</h2>
          <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 py-6 px-2">
            {loading ? (
              <>
                <div className="items-center justify-center absolute w-[60%] text-center top-[50%] left-[20%] z-50 flex flex-col">
                  <span className="flex text-sm pb-3">
                    <Info /> Here are some architectural facts while loading.
                  </span>
                  <span className="type-facts text-2xl " />
                </div>
                <Skeleton />
              </>
            ) : (
              data?.map((item, index) => (
                <div
                  key={item.id}
                  className={`group relative aspect-auto overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75`}
                >
                  <Link href={`/dashboard/design/${item.id}`}>
                    <Image
                      width={512}
                      height={512}
                      src={item.image}
                      alt="Front of men&#039;s Basic Tee in black."
                      className="h-full w-full object-cover object-center lg:h-full lg:w-full"
                    />
                  </Link>
                </div>
              ))
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default List;
