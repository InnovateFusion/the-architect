"use client";
import { Info } from "lucide-react";
import PostCard from "./PostCard";
import Skeleton from "./PostSkeleton";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import { useAllPosts } from "@/app/hooks/usePosts";
import { useInView } from "react-intersection-observer";
import { useRef, useEffect } from "react";
export default function PostList() {
  const router = useRouter()
  const { ref, inView } = useInView();
  const myRef = useRef(null);

  const {
    data,
    isError,
    error,
    isLoading,
    hasNextPage,
    fetchNextPage,
    isSuccess,
    isFetchingNextPage,
  } = useAllPosts();

  useEffect(() => {
    if (inView && hasNextPage) {
      fetchNextPage();
    }
  }, [hasNextPage, inView, fetchNextPage]);

  const posts = data?.pages.map((outerObj) => {
    return Object.values(outerObj);
  });

  if (isLoading)
    return (
      <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 p-3">
        <div className="items-center justify-center absolute w-[60%] text-center top-[50%] left-[20%] z-50 flex flex-col">
          <span className="flex text-sm">
            <Info /> Here are some facts while loading...
          </span>
          <span className="type-facts text-2xl" />
        </div>
        <Skeleton />
      </div>
    );

  if (isError) {
    toast.error("Authentication failed. Please login again.");
    router.push("/auth/signin")
    return
  }

  // render data
  return (
    <div>
      <div className=" grid  sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 space-y-4 py-6 px-2">
        {data?.length == 0 ? (
          <div>No Posts Yet </div>
        ) : (
          isSuccess &&
          data?.pages.map((page) =>
            Object.keys(page)
              .slice(0, -2)
              .map((index) => {
                if (index == Object.keys(page).length - 3) {
                  return (
                    <div ref={ref}>
                      <PostCard key={page[index].id} post={page[index]} />
                    </div>
                  );
                } else {
                  return <PostCard key={page[index].id} post={page[index]} />;
                }
              })
          )
        )}
      </div>
        <div className="flex items-center justify-center">
          {isFetchingNextPage && <p className="mb-4">Loading...</p>}
          {!hasNextPage && <div> You have seen it All!</div>}
        </div>
    </div>
  );
}
