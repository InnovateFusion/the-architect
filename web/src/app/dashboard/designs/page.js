"use client";
import { Info } from "lucide-react";
import PostCard from "./PostCard";
import Skeleton from "./PostSkeleton";
import { usePosts } from "@/lib/requests";

export default function PostList() {
  const { posts, error, isLoading } = usePosts();
  // const designs = await getDesigns();
  if (error) return <div>failed to load</div>;
  if (isLoading)
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
    <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-3 gap-4 space-y-4 py-6 px-2">
      {posts?.length == 0 ? (
        <div>No Posts Yet</div>
      ) : (
        posts?.map((post) => <PostCard key={post.id} post={post} />)
      )}
    </div>
  );
}
