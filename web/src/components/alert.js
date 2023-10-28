import { AlertTriangle, CheckCheck, Megaphone } from "lucide-react";
import React, { useEffect } from "react";

const Alert = ({ message, type }) => {
  useEffect(() => {
    // Automatically close the alert after 5 seconds
    const timeoutId = setTimeout(() => {
      const alert = document.getElementById("alert");
      if (alert) {
        alert.style.animation = "slide-out 0.3s ease-in-out";
        setTimeout(() => {
          alert.remove();
        }, 300);
      }
    }, 5000);

    return () => clearTimeout(timeoutId);
  }, []);

  return type == "red" ? (
    <div
      id="alert"
      className={`absolute bottom-5 left-5 z-50 px-4 py-3 leading-normal text-bold text-white bg-red-700 rounded-lg flex gap-3`}
      role="alert"
    >
      <AlertTriangle />
      <p>{message}</p>
    </div>
  ) : type == "yellow" ? (
    <div
      id="alert"
      className={`absolute bottom-5 left-5 z-50 px-4 py-3 leading-normal text-bold text-white bg-yellow-700 rounded-lg flex gap-3`}
      role="alert"
    >
      {" "}
      <p>{message}</p>
    </div>
  ) : type == "blue" ? (
    <div
      id="alert"
      className={`absolute bottom-5 left-5 z-50 px-4 py-3 leading-normal text-bold text-white bg-blue-600 rounded-lg flex gap-3`}
      role="alert"
    >
      {" "}
      <Megaphone />
      <p>{message}</p>
    </div>
  ) : (
    <div
      id="alert"
      className={`absolute bottom-5 left-5 z-50 px-4 py-3 leading-normal text-bold text-white bg-green-600 rounded-lg flex gap-3`}
      role="alert"
    >
      {" "}
      <CheckCheck />
      <p>{message}</p>
    </div>
  );
};

export default Alert;
