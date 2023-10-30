"use client";
import { Info } from "lucide-react";
import PostCard from "./PostCard";
import Skeleton from "./PostSkeleton";
import { usePosts } from "@/lib/requests";
import { useEffect, useState } from "react";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";

export default function PostList() {
  const router = useRouter();
  const [data, setData] = useState(null);
  const [iserror, seterror] = useState(false);
  const [loading, setloading] = useState(false);

  const getPosts = async () => {
    setloading(true);
    const token = localStorage.getItem("token");
    if (!token) {
      toast.error("Invalid Credentials. Please Sign in Again.");
      router.push("/auth/signin");
      return;
    }

    const url = `https://the-architect.onrender.com/api/v1/posts/all?limit=30`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    if (res.status == 200) {
      const posts = await res.json();
      setData(posts);
    }else{
      
    }
    setloading(false);
  };

  useEffect(() => {
    getPosts();
  }, []);

  if (iserror) return <div>failed to load</div>;
  if (loading)
    return (
      <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 p-3">
        <div className="items-center justify-center absolute w-[60%] text-center top-[50%] left-[20%] z-50 flex flex-col">
          <span className="flex text-sm">
            <Info /> Here are some facts while loading.
          </span>
          <span className="type-facts text-2xl" />
        </div>
        <Skeleton />
      </div>
    );

  // render data
  return (
    <div className=" grid  sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-4 space-y-4 py-6 px-2">
      {data?.length == 0 ? (
        <div>No Posts Yet</div>
      ) : (
        data && data?.map((post) => <PostCard key={post.id} post={post} />)
      )}
    </div>
  );
}
