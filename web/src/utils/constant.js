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
  { code: "image_from_text", name: "Exterior Design" },
  { code: "chatbot", name: "Lets talk about Architecture" },
  { code: "text_to_3D", name: "Imagine the 3D" },
  // { code: "analysis", name: "Analyze my Design" },
  // { code: "image_variant", name: "Design Variation" },
  // { code: "image_to_image", name: "Reference this" },
  // { code: "instruction", name: "Fix my Design" },
  // { code: "edit_image", name: "Edit my Design" },
];

export const models2 = [
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
  // { code: "image_to_3D", name: "Design to 3D" },
];

export const services = [
  {
    title: "Inspirational Designs",
    image: "",
    link: "/dashboard/designs",
    desc: "Collaborate and get inspirations from architects all around the world.",
  },
  {
    title: "Idea to Image",
    image:
      "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698149548/llbmrllk1egq4sndgyr4.jpg",
    link: "/dashboard/draw?model=text_to_image",
    desc: "State your imaginations with simple language and get the images without hussle.",
  },
  {
    title: "Drawing to Render",
    image:
      "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698267218/ufnmlna5rxqazgplunmv.jpg",
    link: "/dashboard/draw?model=controlNet",
    desc: "Your simple Sketches will be converted into photorealitic renders.",
  },
  {
    title: "Architectural Knowledge",
    image:
      "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%",
    link: "/dashboard/draw?model=chatbot",
    desc: "Your architectural companion helps you not only designing but also answering your questions.",
  },
  {
    title: "Describe my Design",
    image:
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1887&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    link: "/dashboard/draw?model=analysis",
    desc: "Get the details of your design from the architects perspective.",
  },
  {
    title: "3D item Models",
    image: "",
    link: "/dashboard/draw?model=text_to_3D",
    desc: "Collaborate and get inspirations from architects all around the world.",
  },
];