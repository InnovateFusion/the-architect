"use client";
import React from "react";
import ImageZoom from "react-image-zooom";
import TagSelector from "./tags";
import Image from "next/image";
import DesignView from "../designs/DesignView";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";

export function PostDesign({ image, open, handleOpen }) {
  const router = useRouter()
  const [postTitle, setPostTitle] = React.useState("");
  const [postDescription, setPostDescription] = React.useState("");
  const [selectedtags, setSelectedtags] = React.useState([]);

  const handlePost = async () => {
    if (selectedtags.length > 0 && image) {
      handleOpen();
      const userId = localStorage.getItem("userId");
      const token = localStorage.getItem("token");
      if (!token) {
        toast.error("Invalid Credentials. Please Sign in Again.");
        router.push("/auth/signin");
        return;
      }

      const url = `https://the-architect.onrender.com/api/v1/posts`;

      const res = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          userId: userId,
          image: image,
          title: postTitle,
          content: postDescription,
          tags: selectedtags,
        }),
      });
      if (res.status == 200) {
        const post = await res.json();
        setPostTitle("");
        setPostDescription("");
        setSelectedtags([]);
        toast.success("Your Design Posted Successfully.")
      }
    }
  };

  return (
    <DesignView open={open} handleOpen={handleOpen}>
      <div className="modal-box w-full max-w-5xl">
        <div className="modal-content flex">
          <div className="w-1/2 flex p-3">
            <ImageZoom zoom="300" src={image} width={512} height={512} alt="" />
          </div>
          <div className="w-1/2 flex p-3 flex-col">
            <div className="form-control w-full max-w-xs">
              <label className="label">
                <span className="label-text dark:text-white">
                  Title for your design.
                </span>
              </label>
              <input
                type="text"
                placeholder="Type here"
                className="form-input w-full text-gray-800"
                onChange={(e) => setPostTitle(e.target.value)}
                value={postTitle}
              />
            </div>
            <div className="form-control w-full max-w-xs">
              <label className="label">
                <span className="label-text">Description</span>
              </label>
              <textarea
                placeholder="Type here"
                className="form-input w-full text-gray-800 textarea textarea-bordered textarea-md  max-w-xs"
                onChange={(e) => setPostDescription(e.target.value)}
                value={postDescription}
              />
            </div>
            <div className="form-control w-full max-w-xs">
              <label className="label">
                <span className="label-text">Select some tags.</span>
              </label>
              <TagSelector
                selectedTags={selectedtags}
                setSelectedTags={setSelectedtags}
              />
            </div>
            <button
              className="btn btn-primary mt-3 border-blue-gray-300"
              onClick={handlePost}
            >
              Post Design
            </button>
          </div>
        </div>
      </div>
    </DesignView>
  );
}
