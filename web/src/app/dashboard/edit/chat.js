"use client";

import Image from "next/image";
import { useEffect, useRef, useState } from "react";
import { useSearchParams } from "next/navigation";
import TagSelector from "./tags";

export default function Chat({ changeImage, mode, image, mask }) {
  const [chats, setChats] = useState([
    JSON.stringify({
      sender: "ai",
      content:
        "Hi I'm your design assistant. I'm here to help you in your design process. I can help you by providing inspirational designs based on your needs and help youo modify your designs. Here is my design of the day, I hope you like it :).",
      logo: "/if.png",
    }),
    JSON.stringify({
      sender: "ai",
      content: "/house.jpg",
      logo: "/if.png",
    }),
  ]);
  const [message, setMessage] = useState("");
  const [model, setModel] = useState(mode);
  const [url, setUrl] = useState(
    `https://the-architect.onrender.com/api/v1/chats`
  );
  const [modalImage, setModalImage] = useState("/house.jpg");
  const searchParams = useSearchParams();

  const [chatId, setChatId] = useState(searchParams.get("chatId"));

  const [selectedtags, setSelectedtags] = useState([]);

  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };
  const handleSend = async () => {
    if (mode != "text_to_image") changeImage();
    setMessage("");
    setChats((oldArray) => [
      ...oldArray,
      JSON.stringify({
        sender: "user",
        content: message,
        logo: "/if.png",
      }),
    ]);
    console.log(chats);
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");

    if (chatId != null)
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );

    const res = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({
        user_id: userId,
        payload: {
          model:
            model == "text_to_image"
              ? "xsarchitectural-interior-design"
              : model == "painting"
              ? "stable-diffusion-v1-5-inpainting"
              : "stable-diffusion-v1-5",
          prompt: message,
          controlnet: "scribble-1.1",
          image: image,
          negative_prompt: "Disfigured, cartoon, blurry",
          mask_image: mask ? mask.substr(22) : "",
          strength: 0.5,
          width: 512,
          height: 512,
          steps: 25,
          guidance: 7.5,
          seed: 0,
          scheduler: model == "painting" ? "ddim" : "dpmsolver++",
          output_format: "jpeg",
        },
        model: model,
      }),
    });

    if (res.status == 200) {
      const chat = await res.json();
      if (chatId != null) {
        const x = JSON.stringify(chat);
        setChats((oldArray) => [...oldArray, x]);
      } else {
        setChats([...chats, ...chat.messages]);
        setChatId(chat.id);
      }
      scrollToBottom();
    }
  };

  const getChat = async () => {
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");

    const url = `https://the-architect.onrender.com/api/v1/chats/${chatId}`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    if (res.status == 200) {
      const posts = await res.json();
      setChats([...posts.messages]);
    }
  };

  const [isModalOpen, setModalOpen] = useState(false);

  const openModal = () => {
    // document.getElementById("my_modal_2").showModal();
    setModalOpen(true);
  };

  const closeModal = () => {
    // document.getElementById("my_modal_2").checked = false;
    setModalOpen(false);
  };

  const tags = [
    "exterior",
    "facade",
    "outdoor",
    "landscape",
    "architectural facade",
    "outdoor design",
    "interior",
    "indoor",
    "interior design",
    "space planning",
    "furniture design",
    "decor",
    "lighting",
  ];

  const [postTitle, setPostTitle] = useState("");
  const [postDescription, setPostDescription] = useState("");

  const handlePost = async () => {
    closeModal();
    return;
    if (selectedtags.length > 0 && modalImage) {
      const userId = localStorage.getItem("userId");
      const token = localStorage.getItem("token");

      const url = `https://the-architect.onrender.com/api/v1/posts`;

      const res = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          userId: userId,
          image: modalImage,
          title: postTitle,
          content: postDescription,
          tags: selectedtags,
        }),
      });
      if (res.status == 200) {
        const posts = await res.json();
        setChats([...posts.messages]);
      }
    }
  };

  useEffect(() => {
    if (chatId != null) {
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );
      getChat();
      messagesEndRef.current.scrollIntoView({ behavior: "smooth" });
    }
    scrollToBottom();
  }, []);

  return (
    <div className="h-full flex flex-col">
      <div className=" hidden gap-x-4 p-1">
        <select
          className="select select-primary"
          defaultValue={model}
          onChange={(e) => setModel(e.target.value)}
        >
          <option disabled>Select Project</option>
          <option value="new">New Project</option>
          {}
        </select>
        <select
          className="select select-secondary"
          defaultValue={model}
          onChange={(e) => setModel(e.target.value)}
        >
          <option disabled>Choose your model here.</option>
          <option value="text_to_image">Idea to Design</option>
          <option value="image_to_image">Design Variation</option>
          <option value="controlNet">Drawing to Design</option>
          <option value="painting">Design Modification</option>
          <option value="instruction">Edit my Design</option>
        </select>
      </div>
      <div className="border mx-auto w-full space-y-4 bg-slate-300 overflow-y-auto h-[99vh]">
        {chats.length > 0 ? (
          chats.map((item, index) => {
            const chat = JSON.parse(item);
            return (
              <>
                {chat.sender == "user" ? (
                  <div
                    className="flex justify-end"
                    ref={messagesEndRef}
                    key={chat.id}
                  >
                    <div className="flex w-10/12 flex-row-reverse">
                      {/* <div className="w-12 rounded-full p-1">
                        <Image src="/if.png" width={200} alt="" height={200} />
                      </div> */}
                      <div className="mr-4" />
                      <div className="relative max-w-xl rounded-xl rounded-tr-none bg-blue-600 px-4 py-2">
                        <span className="text-sm font-medium text-white">
                          {chat.content.substr(0, 1) == "/" ||
                          chat.content.substr(0, 4) == "http" ? (
                            <Image
                              src={chat.content}
                              width={200}
                              alt=""
                              height={200}
                              onClick={() => {
                                setModalImage(chat.content);
                                openModal();
                              }}
                              className="hover:cursor-pointer"
                            />
                          ) : (
                            chat.content
                          )}
                        </span>
                      </div>
                    </div>
                  </div>
                ) : (
                  <div
                    className="flex justify-start"
                    ref={messagesEndRef}
                    key={chat.id}
                  >
                    <div className="flex w-10/12">
                      {/* <div className="w-12 rounded-full p-1">
                        <Image
                          src="/logo.svg"
                          width={200}
                          alt=""
                          height={200}
                        />
                      </div> */}
                      <div className="mr-4" />
                      <div className="relative max-w-xl rounded-xl rounded-tl-none bg-slate-900 px-4 py-2">
                        <span className="text-sm font-medium text-heading">
                          {chat.content.substr(0, 1) == "/" ||
                          chat.content.substr(0, 4) == "http" ? (
                            <Image
                              src={chat.content}
                              width={200}
                              alt=""
                              height={200}
                              onClick={() => {
                                setModalImage(chat.content);
                                openModal();
                              }}
                              className="hover:cursor-pointer"
                            />
                          ) : (
                            chat.content
                          )}
                        </span>
                      </div>
                    </div>
                  </div>
                )}
              </>
            );
          })
        ) : (
          <></>
        )}
      </div>
      <div>
        <div className="flex items-center border-2 border-red-700 py-2">
          <input
            type="text"
            placeholder="Type a message..."
            className="appearance-none bg-transparent border-none w-full text-white-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
            onChange={(e) => {
              setMessage(e.target.value);
            }}
            value={message}
            multiple
            min={2}
            onKeyDown={(e) => {
              if (e.key === "Enter" && message != "") {
                e.preventDefault();
                handleSend();
              }
            }}
          />
          {message != "" && (
            <button
              type="submit"
              className="flex-shrink-0 bg-blue-500 hover:bg-blue-700 border-blue-500 hover:border-blue-700 text-sm border-4 text-white py-1 px-2 rounded mx-5"
              onClick={handleSend}
            >
              Generate
            </button>
          )}
        </div>
      </div>
      <dialog
        id="my_modal_2"
        className={`modal ${isModalOpen ? "modal-open" : ""}`}
      >
        <div className="modal-box w-full max-w-5xl">
          <div className="modal-content flex">
            <div className="w-1/2 flex p-3">
              <Image src={modalImage} width={512} height={512} alt="" />
            </div>
            <div className="w-1/2 flex p-3 flex-col">
              <div className="form-control w-full max-w-xs">
                <label className="label">
                  <span className="label-text">Title for your design.</span>
                </label>
                <input
                  type="text"
                  placeholder="Type here"
                  className="input input-bordered w-full max-w-xs"
                  onChange={(e) => setPostTitle(e.target.value)}
                  value={postTitle}
                />
              </div>
              <div className="form-control w-full max-w-xs">
                <label className="label">
                  <span className="label-text">Description</span>
                </label>
                <textarea
                  placeholder="Bio"
                  className="textarea textarea-bordered textarea-md w-full max-w-xs"
                  onChange={(e) => setPostDescription(e.target.value)}
                  value={postDescription}
                />
              </div>
              <div className="form-control w-full max-w-xs">
                <label className="label">
                  <span className="label-text">Select some tags.</span>
                </label>
                <TagSelector
                  tags={tags}
                  selectedTags={selectedtags}
                  setSelectedTags={setSelectedtags}
                />
              </div>
              <button className="btn btn-primary mt-3" onClick={handlePost}>
                Post Design
              </button>
            </div>
          </div>
          <button
            onClick={(e) => {
              changeImage(modalImage);
            }}
          >
            Use as Reference
          </button>
        </div>
        <form method="dialog" className="modal-backdrop">
          <button>close</button>
        </form>
      </dialog>
    </div>
  );
}
