import { useInfiniteQuery, useQuery } from "@tanstack/react-query";
import { usePostStore, usePostsStore } from "@/store/designs";
import APIClient from "@/store/apiClient";

const usePosts = () => {
  const posts = usePostsStore((state) => state.posts);
  const apiClient = new APIClient();
  return useQuery({
    queryKey: [posts, "posts"],
    queryFn: () => apiClient.getAll(),
  });
};

export const usePost = (id) => {
  const posts = usePostStore((state) => state.posts);
  const apiClient = new APIClient();
  return useQuery({
    queryKey: [posts, `post${id}`],
    queryFn: () => apiClient.getPost(id),
  });
};

export const useAllPosts = () => {
  const apiClient = new APIClient();
  return useInfiniteQuery({
    queryFn: ({ pageParam = 0 }) => {
      return apiClient.allPosts({
        limit: 8,
        skip: pageParam,
      });
    },
    queryKey: ["posts"],
    getNextPageParam: (lastPage, allPages) => {
      if (!lastPage.next) {
        return null
      }
      return lastPage.prevSkip;
    },
  });
};
export default usePosts;
