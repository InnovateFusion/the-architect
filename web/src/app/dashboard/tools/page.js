"use client";
import { useEffect, useRef, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import ChatBuble from "../edit/chatBuble";
import { PostDesign } from "../edit/PostDesign";
import { initialMessage, models2 } from "../../../utils/constant";
import { ExcalidrawPage } from "../draw/ExcalidrawPage";
import ImageZoom from "react-image-zooom";
import Image from "next/image";
import { imageUrlToBase64 } from "@/utils/utils";
import Dropzone from "./dropzone";
import Canvas from "./canvas";
import Download from "./download";
import { AlertCircle, Eraser } from "lucide-react";
import Alert from "@/components/alert";
import Loader from "@/components/Loader";
import { toast } from "react-toastify";
import { Step, Step2 } from "@/components/steps";

export default function Chat() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const [image, setImage] = useState(searchParams.get("image") || "");
  const [drawing, setDrawing] = useState("");
  const [mask, setMask] = useState("");
  const [chats, setChats] = useState(initialMessage);
  const [message, setMessage] = useState("");
  const [model, setModel] = useState(searchParams.get("model") || "controlNet");
  const [predictions, setPredictions] = useState([]);
  const [userUploadedImage, setUserUploadedImage] = useState(null);
  const [open, setOpen] = useState(false);
  const [upload, setupload] = useState(false);
  const [chatId, setChatId] = useState(searchParams.get("chatId"));
  const [base64, setbase64] = useState(null);
  const [loading, setLoading] = useState(false);
  const messagesEndRef = useRef(null);
  const excalidrawRef = useRef(null);
  const exportToCanvasRef = useRef(null);
  const [url, setUrl] = useState(
    `https://the-architect.onrender.com/api/v1/chats`
  );

  const [isAlertVisible, setIsAlertVisible] = useState(false);
  const [alertMessage, setAlertMessage] = useState(false);
  const [alertType, setAlertType] = useState(false);

  const hideAlert = () => {
    setIsAlertVisible(false);
  };

  // Function to show the alert
  const showAlert = (message, type) => {
    setAlertMessage(message);
    setAlertType(type);
    setIsAlertVisible(true);

    // Automatically hide the alert after 5 seconds
    setTimeout(() => {
      hideAlert();
    }, 5000);
  };

  const handleOpen = () => {
    setOpen(!open);
  };

  const handleUpload = (image) => {
    setImage(image);
    setupload(true);
  };

  const handleClick = async (img) => {
    setupload(false);
    setImage(img);
    handleBase64(img);
  };

  const handleBase64 = async (img) => {
    await imageUrlToBase64(img, (base64String) => {
      if (base64String) {
        setbase64(base64String);
        // console.log("base", base64);
      } else {
        console.log("Failed to convert image to base64");
        return "";
      }
    });
  };

  const scrollToBottom = () => {
    if (messagesEndRef.current) {
      const chatContainer = messagesEndRef.current;
      const lastMessage = chatContainer.lastChild;
      lastMessage.scrollIntoView({ behavior: "smooth" });
    }
  };

  const handleSend = async () => {
    setLoading(true);
    let userImage = "";
    switch (model) {
      case "controlNet":
        userImage = drawing;
        break;
      case "painting":
        userImage = !upload ? image : URL.createObjectURL(image);
        break;
      case "image_to_image":
      case "edit_image":
      case "analysis":
      case "instruction":
      case "image_to_3D":
      case "image_variant":
        userImage = !upload ? image : URL.createObjectURL(image);
        break;
      case "text_to_3D":
      case "image_from_text":
      case "text_to_image":
      case "chatbot":
      default:
        break;
    }

    await handleBase64(userImage);
    if (
      model != "text_to_image" &&
      model != "image_from_text" &&
      model != "chatbot" &&
      model != "text_to_3D" &&
      !userImage
    ) {
      showAlert("Please Upload or select an Image ", "blue");
      setLoading(false);
      return;
    }

    setChats((oldArray) => [
      ...oldArray,
      JSON.stringify({
        sender: "user",
        content: {
          prompt: message,
          chat: "",
          imageUser: userImage,
          imageAI: "",
          model: model,
          analysis: {
            title: "",
            detail: "",
          },
          "3D": {
            status: "",
            fetch_result: "",
          },
        },
      }),
    ]);

    setMessage("");
    scrollToBottom();

    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");
    if (!token) {
      toast.error("Invalid Credentials. Please Sign in Again.");
      router.push("/auth/signin");
      return;
    }

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
          image: model == "controlNet" ? drawing.substring(22) : base64,
          negative_prompt: "Disfigured, cartoon, blurry",
          mask_image: model == "painting" ? mask.substring(22) : "",
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
    } else {
      const { detail } = await res.json();
      showAlert(detail, "red");
    }
    setLoading(false);
  };

  async function getCanvasUrl() {
    if (!excalidrawRef.current?.ready) return;

    const elements = excalidrawRef.current.getSceneElements();
    if (!elements || !elements.length) {
      return;
    }

    const canvas = await exportToCanvasRef.current({
      elements: elements,
      mimeType: "image/png",
      //appState: excalidrawRef.current.getAppState(),
      files: excalidrawRef.current.getFiles(),
      getDimensions: () => {
        return { width: 512, height: 512 };
      }, // experiment with this for cheaper replicate API.
    });

    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    ctx.font = "30px Virgil";
    setDrawing(canvas.toDataURL());
    return canvas.toDataURL();
  }

  const handleSubmit = async (e) => {
    console.log("createPrediction.....");

    const canvasUrl = await getCanvasUrl();
    if (!canvasUrl) {
      setDrawing("");
      return "";
    }
    setDrawing(canvasUrl);
    return canvasUrl;
  };

  useEffect(() => {
    if (chatId != null) {
      setUrl(
        `https://the-architect.onrender.com/api/v1/chats/${chatId}/messages`
      );

      const getChat = async () => {
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
          setChats([...initialMessage, ...posts.messages]);
          scrollToBottom();
        }
      };
      getChat();
    }
  }, []);

  const startOver = async () => {
    // e.preventDefault();
    setPredictions([]);
    setMask("");
    setImage("");
    setupload(false);
    setDrawing("");
    setUserUploadedImage("");
  };

  return (
    <div className="h-[98%] sm:flex ">
      <div className="gap-2 w-full sm:w-1/2 min-h-[532px] flex flex-col justify-top items-center p-4">
        {model == "controlNet" ? (
          <ExcalidrawPage
            excalidrawRef={excalidrawRef}
            exportToCanvasRef={exportToCanvasRef}
            changeImage={getCanvasUrl}
          />
        ) : model == "painting" ? (
          !image ? (
            <Dropzone
              onImageDropped={handleUpload}
              predictions={predictions}
              userUploadedImage={image}
            />
          ) : (
            <div className="h-[512px] flex items-center ">
              <Canvas
                predictions={predictions}
                userUploadedImage={upload ? URL.createObjectURL(image) : image}
                onDraw={setMask}
              />
            </div>
          )
        ) : model == "text_to_image" ? (
          !image ? (
            <div className="h-[512px] flex items-center rounded-md border border-gray-600 w-[512px] justify-center ">
              <Step />
            </div>
          ) : (
            <ImageZoom
              zoom="300"
              height={512}
              width={512}
              alt="gallery"
              src={upload ? URL.createObjectURL(image) : image}
              className="rounded-lg border border-gray-600"
            />
          )
        ) : model == "image_to_image" ||
          model == "image_from_text" ||
          model == "edit_image" ||
          model == "analysis" ||
          model == "image_variant" ||
          model == "instruction" ? (
          !image ? (
            <Dropzone
              onImageDropped={handleUpload}
              predictions={predictions}
              userUploadedImage={image}
            />
          ) : (
            <ImageZoom
              zoom="300"
              height={512}
              width={512}
              alt="gallery"
              src={upload ? URL.createObjectURL(image) : image}
              className="rounded-lg border border-gray-600"
            />
          )
        ) : model == "text_to_3D" ? (
          <div className="h-[512px] flex items-center rounded-md border border-gray-600 w-[512px] justify-center ">
            Takes ages to Produce
          </div>
        ) : model == "chatbot" ? (
          <div className="h-[512px] flex items-center rounded-md border border-gray-600 w-[512px] justify-center ">
            <Step2 />
          </div>
        ) : (
          <ImageZoom
            zoom="300"
            height={512}
            width={512}
            alt="gallery"
            src={image || "/house.jpg"}
            className="rounded-lg border"
          />
        )}
        <div className="w-full p-2 flex justify-around">
          {model !== "controlNet" && (image || mask) && (
            <button className="btn bg-red-300 flex gap-2" onClick={startOver}>
              <Eraser />
              Clear
            </button>
          )}
          {model !== "controlNet" && image && (
            <Download
              lastImage={!upload ? image : URL.createObjectURL(image)}
              predictions={predictions}
            />
          )}
        </div>
      </div>
      <div className="w-full sm:w-1/2">
        <div className=" gap-x-4 p-1">
          <select
            className="block w-full border-1  rounded-lg px-4 py-2 outline-none focus:ring focus:ring-indigo-400"
            defaultValue={model}
            onChange={(e) => {
              setModel(e.target.value);
            }}
          >
            <option disabled>Choose your model here.</option>
            {models2.map((m, i) => (
              <option key={i} value={m.code}>
                {m.name}
              </option>
            ))}
          </select>
        </div>
        <div className="h-[97%] flex flex-col">
          <div
            className="p-2 border dark:border dark:border-gray-600 rounded-2xl mx-auto w-full space-y-4 bg-slate-300 overflow-y-auto h-[99vh]"
            id="chat-container"
            ref={messagesEndRef}
          >
            {chats.length > 0 &&
              chats.map((chat, index) => {
                return (
                  <ChatBuble
                    key={index}
                    m={chat}
                    handleOpen={handleOpen}
                    setImage={handleClick}
                  />
                );
              })}
            {loading && <Loader />}
            <h1 className="text-sm flex">
              <AlertCircle size={20} /> The Generative AI model might produce
              incomplete and inaccurate data.
            </h1>
          </div>
          <div>
            <div className="flex items-center py-2">
              <textarea
                autoFocus
                className="block w-full rounded-lg px-4 py-2 mx-2 outline-none focus:ring focus:ring-indigo-400 resize-none dark:bg-gray-800 dark:border dark:border-gray-600 dark:text-white bg-white border border-gray-300 text-black"
                rows="2"
                onChange={(e) => {
                  setMessage(e.target.value);
                }}
                value={message}
                min={2}
                onKeyDown={(e) => {
                  if (e.key === "Enter" && message != "") {
                    e.preventDefault();
                    handleSend();
                  }
                }}
                placeholder="Write your imagination here. The sky is the limit..."
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
          {open && (
            <PostDesign
              open={open}
              handleOpen={handleOpen}
              image={image || "/house.jpg"}
            />
          )}
        </div>
      </div>
      {isAlertVisible && <Alert message={alertMessage} type={alertType} />}
    </div>
  );
}
