import React from "react";

function Loader() {
  return (
    <div className="flex justify-center items-center ">
      <div className="loader bg-gray-200 dark:bg-gray-800 p-5 rounded-full flex space-x-3">
        <div className="w-5 h-5 dark:bg-white bg-gray-800 rounded-full animate-bounce"></div>
        <div className="w-5 h-5 dark:bg-white bg-gray-800 rounded-full animate-bounce"></div>
        <div className="w-5 h-5 dark:bg-white bg-gray-800 rounded-full animate-bounce"></div>
      </div>
    </div>
  );
}

export default Loader;
