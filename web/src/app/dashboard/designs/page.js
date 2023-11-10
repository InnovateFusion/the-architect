"use client";
import { Info } from "lucide-react";
import PostCard from "./PostCard";
import Skeleton from "./PostSkeleton";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import { useAllPosts } from "@/hooks/usePosts";
import { useInView } from "react-intersection-observer";
import { useRef, useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import Tags from "./tags";
export default function PostList() {
  const router = useRouter();
  const { ref, inView } = useInView();
  const searchParams = useSearchParams();
  const {
    data,
    isError,
    error,
    isLoading,
    hasNextPage,
    fetchNextPage,
    isSuccess,
    isFetchingNextPage,
  } = useAllPosts({
    search: searchParams.get("search"),
    tag: searchParams.get("tags"),
  });

  const [search, setSearch] = useState(searchParams.get("search") || "");
  const [tag, setTag] = useState(searchParams.get("tags") || "");

  useEffect(() => {
    if (inView && hasNextPage) {
      fetchNextPage();
    }
  }, [hasNextPage, inView, fetchNextPage]);

  if (isLoading)
    return (
      <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 p-3">
        <div className="items-center justify-center absolute w-[60%] text-center top-[50%] left-[20%] z-50 flex flex-col">
          <span className="flex text-sm">
            <Info /> Getting design inspirations is easy with our community...
            {/* Here are some architectural facts while loading. */}
          </span>
          {/* <span className="type-facts text-2xl" /> */}
        </div>
        <Skeleton />
      </div>
    );

  if (isError) {
    if (error?.response?.status == 401) {
      toast.error("Authentication failed. Please login again.");
      router.push("/auth/signin");
      return;
    } else toast.error("Something went wrong.");
    return <div className="items-center">Something went wrong</div>;
  }

  // render data
  return (
    <div>
      <div className="box p-6 shadow w-full sticky top-0 z-50 px-2 py-2 bg-transparent gap-2 backdrop-blur-sm flex flex-row justify-start md:justify-start items-start mx-auto ">
        <div className="box-wrapper w-fit">
          <div className=" rounded flex items-center w-full p-2 shadow-sm border border-gray-500">
            <input
              type="search"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              name=""
              id=""
              placeholder="Search for designs with AI..."
              x-model="q"
              className="w-full pl-2 text-sm outline-none focus:outline-none bg-transparent"
              onKeyDown={(e) => {
                if (e.key === "Enter" && search != "") {
                  router.push(
                    `/dashboard/designs/search?search=${search}&tags=${tag}`
                  );
                }
              }}
            />
            <button
              className="outline-none focus:outline-none"
              onClick={() =>
                router.push(
                  `/dashboard/designs/search?search=${search}&tags=${tag}`
                )
              }
            >
              <svg
                className=" w-5  h-5 cursor-pointer"
                fill="none"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
            </button>
          </div>
        </div>
        <Tags setTag={setTag} />
      </div>
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
                    <div key={page[index].id}>
                      <PostCard innerRef={ref} post={page[index]} />
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
