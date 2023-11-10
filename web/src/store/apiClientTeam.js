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

class TeamAPIClient {
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
  getUser = async (id) => {
    const response = await axiosInstance.get(`users/${id}/${id}`, {
      headers: token,
    });
    return response.data;
  };

  getPost = async (id) => {
    const response = await axiosInstance.get(`posts/${id}`, {
      headers: token,
    });
    return response.data;
  };

  generate = async (prompt) => {
    if (!prompt) return;
    const response = await fetch(
      `https://the-architect.onrender.com/api/v1/free`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ prompt: prompt }),
      }
    );
    const data = await response.json();
    return data;
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

  myTeams = async () => {
    const response = await axiosInstance.get(`teams`, {
      headers: token,
    });
    return response.data;
  };

  createTeam = async ({ title, description, image, user_ids }) => {
    const response = await axiosInstance.post(`teams`, {
      method: "POST",
      headers: token,
      body: JSON.stringify({ title, description, image, user_ids }),
    });
    return response.data;
  };
  updateTeam = async ({ id, title, description, image, user_ids }) => {
    const response = await axiosInstance.put(`teams/${id}`, {
      method: "PUT",
      headers: token,
      body: JSON.stringify({ title, description, image, user_ids }),
    });
    return response.data;
  };

  deleteTeam = async (id) => {
    const response = await axiosInstance.delete(`teams/${id}`, {
      method: "DELETE",
      headers: token,
    });
    return response.data;
  };

  getTeam = async (id) => {
    const response = await axiosInstance.get(`teams/${id}`, {
      headers: token,
    });
    return response.data;
  };

  joinTeam = async (id, userId) => {
    const response = await axiosInstance.get(
      `teams/${id}/users/${userId}/join`,
      {
        headers: token,
      }
    );
    return response.data;
  };

  leaveTeam = async (id, userId) => {
    const response = await axiosInstance.get(
      `teams/${id}/users/${userId}/leave`,
      {
        headers: token,
      }
    );
    return response.data;
  };

  getAllMembers = async (id) => {
    const response = await axiosInstance.get(`users`, {
      headers: token,
    });
    return response.data;
  };

  getMembers = async (id) => {
    const response = await axiosInstance.get(`teams/${id}/members`, {
      headers: token,
    });
    return response.data;
  };
  addMembers = async (id, user_ids) => {
    const response = await axiosInstance.post(`teams/${id}/add-users`, {
      headers: token,
      body: JSON.stringify({ user_ids }),
    });
    return response.data;
  };

  sendMessage = async (id, userId, payload, model, isTeam) => {
    const response = await axiosInstance.post(`chats/${id}/messages`, {
      headers: token,
      body: JSON.stringify({ userId, payload, model, isTeam }),
    });
    return response.data;
  };
  getMessages = async (id) => {
    const response = await axiosInstance.get(`chats/${id}`, {
      headers: token,
    });
    return response.data;
  };
  createSketch = async (id, title) => {
    const response = await axiosInstance.post(`teams/${id}/sketches`, {
      headers: token,
      body: JSON.stringify({ title }),
    });
    return response.data;
  };

  getSketches = async (id) => {
    const response = await axiosInstance.get(`teams/${id}/sketches`, {
      headers: token,
    });
    return response.data;
  };

  updateSketch = async (id, sketchId, title) => {
    const response = await axiosInstance.put(
      `teams/${id}/sketches/${sketchId}`,
      {
        headers: token,
        body: JSON.stringify({ title }),
      }
    );
    return response.data;
  };

  deleteSketch = async (sketchId) => {
    const response = await axiosInstance.delete(`sketches/${sketchId}`, {
      headers: token,
    });
    return response.data;
  };

  getSketch = async (sketchId) => {
    const response = await axiosInstance.put(`sketches/${sketchId}`, {
      headers: token,
    });
    return response.data;
  };
}

export default TeamAPIClient;
