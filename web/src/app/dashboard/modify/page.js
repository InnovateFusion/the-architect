"use client";
import { useState } from "react";
import Head from "next/head";
import Link from "next/link";
import Canvas from "./canvas";
import PromptForm from "./prompt-form";
import Dropzone from "./dropzone";
import Download from "./download";
import Chat from "../edit/chat";

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

export default function Home() {
  const [predictions, setPredictions] = useState([]);
  const [error, setError] = useState(null);
  const [maskImage, setMaskImage] = useState(null);
  const [userUploadedImage, setUserUploadedImage] = useState(null);
  const [image, setImage] = useState("/house.jpg");
  const [mask, setMask] = useState("/house.jpg");
  const handleChangeImage = (link) => {
    setImage(link);
  };

  const [url, setUrl] = useState(
    `https://the-architect.onrender.com/api/v1/chats`
  );

  const handleSubmit = async (e) => {
    const prevPrediction = predictions[predictions.length - 1];
    const prevPredictionOutput = prevPrediction?.output
      ? prevPrediction.output[prevPrediction.output.length - 1]
      : null;

    const init_image = userUploadedImage
      ? await readAsDataURL(userUploadedImage)
      : // only use previous prediction as init image if there's a mask
      maskImage
      ? prevPredictionOutput
      : "";
    const mask = maskImage;

    setImage(init_image);
    console.log(init_image);
    console.log(mask);
    setMask(mask);
  };

  const startOver = async (e) => {
    e.preventDefault();
    setPredictions([]);
    setError(null);
    setMaskImage(null);
    setUserUploadedImage(null);
  };

  return (
    <div className="h-full sm:flex ">
      <main className="container mx-auto p-5">
        {error && <div>{error}</div>}

        <div className="border-hairline max-w-[512px] mx-auto relative">
          <Dropzone
            onImageDropped={setUserUploadedImage}
            predictions={predictions}
            userUploadedImage={userUploadedImage}
          />
          <div
            className="bg-gray-50 relative max-h-[512px] w-full flex items-stretch"
            // style={{ height: 0, paddingBottom: "100%" }}
          >
            <Canvas
              predictions={predictions}
              userUploadedImage={userUploadedImage}
              onDraw={setMaskImage}
            />
          </div>
        </div>

        <div className="max-w-[512px] mx-auto">
          {/* <PromptForm onSubmit={handleSubmit} /> */}

          <div className="text-center">
            {((predictions.length > 0 &&
              predictions[predictions.length - 1].output) ||
              maskImage ||
              userUploadedImage) && (
              <button className="lil-button" onClick={startOver}>
                Start over
              </button>
            )}

            <Download predictions={predictions} />
          </div>
        </div>
      </main>
      <div className="w-full sm:w-1/2">
        <Chat
          changeImage={handleSubmit}
          mode="inpainting"
          image={image}
          mask={mask}
        />
      </div>
    </div>
  );
}

function readAsDataURL(file) {
  return new Promise((resolve, reject) => {
    const fr = new FileReader();
    fr.onerror = reject;
    fr.onload = () => {
      resolve(fr.result);
    };
    fr.readAsDataURL(file);
  });
}
