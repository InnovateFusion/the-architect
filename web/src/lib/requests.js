import useSWR from "swr";
const fetcher = (...args) => fetch(...args).then((res) => res.json());
export function usePosts() {
  const { data, error, isLoading } = useSWR(
    "https://the-architect.onrender.com/api/v1/posts/all",
    fetcher
  );

  return {
    posts: data,
    isLoading,
    isError: error,
  };
}
