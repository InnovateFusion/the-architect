import { ThumbsUp } from "lucide-react";
import React, { useState } from "react";

const LikeButton = ({ liked, likes }) => {
  const [isLiked, setIsLiked] = useState(liked);

  const toggleLike = () => {
    setIsLiked(!isLiked);
  };

  return (
    <div>
      <button
        onClick={toggleLike}
        className={`flex space-x-1 gap-1 justify-center items-start focus:outline-none ${
          isLiked ? "text-blue-700" : "text-blue-500"
        }`}
      >
        {likes + isLiked}
        {isLiked ? <ThumbsUp fill="rgb(0 100 218)" /> : <ThumbsUp />}
      </button>
    </div>
  );
};

export default LikeButton;
