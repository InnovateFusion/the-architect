import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs) {
  return twMerge(clsx(inputs));
}

export function Capitalize(str) {
  if (!str) return "";
  return str?.charAt(0).toUpperCase() + str?.slice(1);
}

export async function imageUrlToBase64(url, callback) {
  // Fetch the image
  await fetch(url)
    .then((response) => response.blob())
    .then((blob) => {
      const reader = new FileReader();
      reader.onload = function () {
        const base64String = reader.result.split(",")[1];
        callback(base64String);
      };
      return reader.readAsDataURL(blob);
    })
    .catch((error) => {
      console.error("Error fetching and converting image:", error);
      callback(null);
    });
}