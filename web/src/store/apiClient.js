import axios from "axios";

const axiosInstance = axios.create({
  baseURL: `${
    process.env.HOST || "https://the-architect.onrender.com"
  }/api/v1/`,
  headers: {
    "x-auth-token":
      typeof window !== "undefined" ? localStorage?.getItem("token") : "",
  },
});

const token = {
  "Content-Type": "application/json",
  "x-auth-token":
    typeof window !== "undefined" ? localStorage?.getItem("token") : "",
  Authorization: `Bearer ${
    typeof window !== "undefined" ? localStorage?.getItem("token") : ""
  }`,
};

class APIClient {
  endpoint;

  constructor(endpoint) {
    this.endpoint = endpoint;
  }

  getAll = async ({ limit, search_word, tags }) => {
    const response = await axiosInstance.get(
      `posts/all?limit=${limit ? limit : "8"}${
        search_word ? "&search_word=" + search_word : ""
      }${tags ? tags.map((tag) => "&tags=" + tag) : ""}`,
      {
        headers: token,
      }
    );
    return response.data;
  };

  getPost = async (id) => {
    const response = await axiosInstance.get(`posts/${id}`, {
      headers: token,
    });
    return response.data;
  };

  allPosts = async ({ limit, skip, tags, search_word }) => {
    const response = await axiosInstance.get(`posts/all`, {
      headers: token,
      params: { limit, skip, tags, search_word },
    });
    return {
      ...response?.data,
      prevSkip: skip + 1 || 1,
      next: response?.data?.length == limit,
    };
  };
}

export default APIClient;
