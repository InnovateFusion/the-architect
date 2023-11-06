import { useInfiniteQuery, useQuery } from "@tanstack/react-query";
import { usePostStore, usePostsStore } from "@/store/store";
import APIClient from "@/store/apiClient";

const usePosts = (prop) => {
  const posts = usePostsStore((state) => state.posts);
  const apiClient = new APIClient();
  return useQuery({
    queryKey: [posts, "posts"],
    queryFn: () => apiClient.getAll(prop),
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

export const useAllPosts = ({search, tag}) => {
  const apiClient = new APIClient();
  return useInfiniteQuery({
    queryFn: ({ pageParam = 0 }) => {
      return apiClient.allPosts({
        limit: 8,
        skip: pageParam,
        search_word: search || null,
        tags: tag || null,
      });
    },
    queryKey: ["posts"],
    getNextPageParam: (lastPage, allPages) => {
      if (!lastPage.next) {
        return null;
      }
      return lastPage.prevSkip;
    },
  });
};
export default usePosts;
