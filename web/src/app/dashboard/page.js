import Image from "next/image";
import Link from "next/link";
export default function Test() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
      {[
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
      ].map((e, i) => (
        <div className="max-w-sm w-full lg:max-w-full lg:flex" key={i}>
          <Image
            className="h-48 lg:h-auto lg:w-48 flex-none bg-cover rounded-tl-lg lg:rounded-t-none lg:rounded-l text-center overflow-hidden"
            src={e.image || "/house.jpg"}
            width={512}
            height={512}
            alt="Avatar of Jonathan Reinink"
          />
          <div className="border-r border-b border-l border-gray-400 lg:border-l-0 lg:border-t lg:border-gray-400 bg-white rounded-b lg:rounded-b-none lg:rounded-r p-4 flex flex-col justify-between leading-normal">
            <div className="mb-8">
              <p className="text-sm text-gray-600 flex items-center">
                <svg
                  className="fill-current text-gray-500 w-3 h-3 mr-2"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                >
                  <path d="M4 8V6a6 6 0 1 1 12 0v2h1a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-8c0-1.1.9-2 2-2h1zm5 6.73V17h2v-2.27a2 2 0 1 0-2 0zM7 6v2h6V6a3 3 0 0 0-6 0z" />
                </svg>
                New
              </p>
              <div className="text-gray-900 font-bold text-xl mb-2">
                <Link href={e.link}>{e.title}</Link>
              </div>
              <p className="text-gray-700 text-base">{e.desc}</p>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
