"use client";

import React, { useCallback } from "react";
import { useDropzone } from "react-dropzone";

export default function Dropzone(props) {
  const onImageDropped = props.onImageDropped;
  const onDrop = useCallback(
    (acceptedFiles) => {
      onImageDropped(acceptedFiles[0]);
    },
    [onImageDropped]
  );
  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      "image/png": [".png"],
      "image/gif": [".gif"],
      "image/jpeg": [".jpg", ".jpeg"],
    },
  });

  if (props.userUploadedImage) return null;

  return (
    <div
      className="relative z-50 flex w-full h-full text-gray-500 text-sm text-center cursor-pointer select-none max-w-[512px] max-h-[512px] mx-auto border-hairline border border-gray-600 rounded-md"
      {...getRootProps()}
    >
      <div className="m-auto">
        <input {...getInputProps()} />
        {isDragActive ? (
          <p>Drop the image here ...</p>
        ) : (
          <p>Click here to Add your oun design from File. <br /> or <br /> Click the designs form the chat window to enhance previous designs.</p>
        )}
      </div>
    </div>
  );
}
