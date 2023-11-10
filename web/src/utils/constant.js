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
  { code: "instruction", name: "Modify my Design" },
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
    image:
      "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698267218/ufnmlna5rxqazgplunmv.jpg",
    link: "/dashboard/designs",
    desc: "Collaborate and get inspirations from architects all around the world.",
  },
  {
    title: "Idea to Image",
    image:
      "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698149548/llbmrllk1egq4sndgyr4.jpg",
    link: "/dashboard/tools?model=text_to_image",
    desc: "State your imaginations with simple language and get the images without hussle.",
  },
  {
    title: "Drawing to Render",
    image: "/draw.jpg",
    link: "/dashboard/tools?model=controlNet",
    desc: "Your simple Sketches will be converted into photorealitic renders.",
  },
  {
    title: "Architectural Knowledge",
    image: "/think.jpg",
    link: "/dashboard/tools?model=chatbot",
    desc: "Your architectural companion helps you not only designing but also answering your questions.",
  },
  {
    title: "Describe my Design",
    image: "",
    link: "/dashboard/tools?model=analysis",
    desc: "Get the details of your design from the architects perspective.",
  },
  {
    title: "3D item Models",
    image:
      "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%",
    link: "/dashboard/tools?model=text_to_3D",
    desc: "Collaborate and get inspirations from architects all around the world.",
  },
];

export const pricing = [
  {
    name: "Free",
    description: "Get started with essential features for personal use.",
    features: [
      "Basic design concept generation and inspiration designs",
      "Limited interior design and furniture generative features",
      "Access to the built-in drawing and design tool with basic features",
      "Limited drawing to render generation",
      "Basic floor plan generation",
      "Access to community support",
    ],
    priceD: "0",
    duration: "forever",
    priceB: "0",
    link: "free-tier-link",
  },
  {
    name: "Starter",
    description: "Best option for personal use & for your next project.",
    features: [
      "Basic design concept generation and inspiration designs",
      "Limited interior design and furniture generation",
      "Access to the built-in drawing and design tool with basic features",
      "Limited drawing to render generation",
      "Design modification and variation suggestions",
      "Enhanced floor plan generation",
      "Access to community support",
    ],
    priceD: "9.99",
    duration: "month",
    priceB: "999.99",
    link: "link-to-starter-tier",
  },
  {
    name: "Professional",
    description:
      "Unlock advanced features for professional architects and designers.",
    features: [
      "Full design concept generation and inspiration designs",
      "Advanced interior design and furniture generative capabilities",
      "Complete access to the built-in drawing and design tool with advanced features",
      "Fast and high-quality drawing to render generation",
      "Comprehensive design modification and variation suggestions",
      "Advanced floor plan generation",
      "Priority customer support",
      "Access to community and professional forums",
    ],
    priceD: "29.99",
    duration: "month",
    priceB: "2999.99",
    link: "link-to-professional-tier",
  },
  {
    name: "Enterprise",
    description:
      "Tailored solutions for architecture firms and large-scale projects.",
    features: [
      "All features from the Professional Tier",
      "Market research, trend analysis, and cost estimation tools",
      "Advanced collaboration and project management tools",
      "Custom AI model training and integration options",
      "Dedicated account manager",
      "Service level agreements (SLAs)",
      "Custom branding and white-labeling options",
      "On-site training and support",
    ],
    price: "Customized",
    link: "contact-us-for-enterprise-tier",
  },
];

export const prompts = [
  "modern villa inspired by a rooster, ultra detailed, matte painting, overlooking a valley, big trees, clouds, dramatic lighting, artstation, matte painting, raphael lacoste, simon stalenhag, frank lloyd wright, drone view",
  "futuristic bauhaus house concept, 3 d render, octane renderer, raytracing, 8 k resolution, rim light, hyperrealistic, photorealistic, high definition, highly detailed, tehnicolor, architecture photography, masterpiece",
  "indone house of indochine style, soft, filter, noise..",
  "Create a commercial building that seamlessly integrates with its natural surroundings. Use organic materials, such as wood and stone, and incorporate plenty of green spaces, indoor gardens, and natural lighting.",
];