"use client"
import PostCard from "./PostCard";
import Skeleton from "./PostSkeleton";
import { usePosts } from "@/lib/requests"

export default function PostList() {
  const { posts, error, isLoading } = usePosts()
  // const designs = await getDesigns();
  if (error) return <div>failed to load</div>;
  if (isLoading) return <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 p-3"><Skeleton /></div>;

  // render data
  return (
    <div className="columns-1 sm:columns-2 md:columns-3 lg:columns-4 gap-4 space-y-4 p-3">
      {posts?.length == 0 ? (
        <div>No Posts Yet</div>
      ) : (
        posts?.map((post) => <PostCard key={post.id} post={post} />)
      )}
    </div>
  );
}
