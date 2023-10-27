export const initialMessage = [
  JSON.stringify({
    sender: "ai",
    content: {
      chat: "Hi I'm your design assistant. I'm here to help you in your design process. I can help you by providing inspirational designs based on your needs and help you modify your designs. Here is my design of the day, I hope you like it :).",
      prompt: "",
      imageUser: "",
      imageAI: "",
      model: "text_to_image",
      analysis: {
        title: "",
        detail: "",
      },
      "3D": {
        status: "",
        fetch_result: "",
      },
    },
    logo: "/if.png",
  }),
  JSON.stringify({
    sender: "ai",
    content: {
      prompt: "",
      imageUser: "",
      imageAI:
        "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698267218/ufnmlna5rxqazgplunmv.jpg",
      model: "text_to_image",
      analysis: {
        title: "",
        detail: "",
      },
      "3D": {
        status: "",
        fetch_result: "",
      },
      chat: "",
    },
    logo: "/if.png",
  }),
];

export const models = [
  { code: "text_to_image", name: "Interior Design" },
  { code: "image_to_image", name: "Reference this" },
  { code: "controlNet", name: "Drawing to Design" },
  { code: "painting", name: "Design Modification" },
  { code: "instruction", name: "Edit my Design" },
  { code: "image_variant", name: "Design Variation" },
  { code: "image_from_text", name: "Exterior Design" },
  { code: "edit_image", name: "Edit my Design" },
  { code: "chatbot", name: "Lets talk about Architecture" },
  { code: "analysis", name: "Analyze my Design" },
  { code: "text_to_3D", name: "Imagine the 3D" },
  { code: "image_to_3D", name: "Design to 3D" },
];
