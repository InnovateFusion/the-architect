import { create } from "zustand";
import { devtools } from "zustand/middleware";
import { imageUrlToBase64 } from "@/utils/utils";

export const usePostsStore = create((set) => ({
  posts: [],
  setPosts: (data) => set({ posts: data }),
}));

export const usePostStore = create((set) => ({
  post: [],
  setPost: (data) => set({ post: data }),
}));

export const useEditStore = create(
  devtools((set) => ({
    model: "text_to_image",
    setModel: (data) => set({ model: data }),

    image: "",
    setImage: (data) => {
      set({ image: data });
    },

    base64: "",

    setbase64: (data) => {
      set({ base64: data });
    },
    getBase64: async (data) => {
      await imageUrlToBase64(data, (base64String) => {
        set({ base64: base64String });
      });
    },
    clearImage: () => set({ base64: "", image: "" }),
  }))
);

const designsStore = create((set, get) => ({
  designs: [],
  selectedDesign: null,
  isLoading: false,
  error: null,

  // Fetch designs from API
  fetchDesigns: async () => {
    set({ isLoading: true });
    try {
      const response = await fetch(
        "https://the-architect.onrender.com/api/v1/posts/all"
      );
      const designs = await response.json();
      set({ designs, isLoading: false });
    } catch (error) {
      set({ error, isLoading: false });
    }
  },

  // Select a design by ID
  selectDesign: (id) => {
    const selectedDesign = get().designs.find((design) => design.id === id);
    set({ selectedDesign });
  },

  // Add a new design
  addDesign: (design) => {
    const designs = [...get().designs, design];
    set({ designs });
  },

  // Update an existing design
  updateDesign: (id, updatedDesign) => {
    const designs = get().designs.map((design) =>
      design.id === id ? updatedDesign : design
    );
    set({ designs });
  },

  // Delete a design by ID
  deleteDesign: (id) => {
    const designs = get().designs.filter((design) => design.id !== id);
    set({ designs });
  },
}));

export default designsStore;
