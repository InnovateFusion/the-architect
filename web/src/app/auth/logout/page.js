"use client";
import { useRouter } from "next/navigation";
import React, { useEffect } from "react";
import Image from "next/image"
import { toast } from "react-toastify";

export default function App() {
  const router = useRouter();
  const notify = () => toast.success("See You Again");
  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("plan");
    localStorage.removeItem("userId");
    router.push("/home");
  };

  useEffect(() => {
    handleLogout();
  }, []);

  return (
    <div className="flex flex-col align-center items-center justify-center h-full text-5xl">
      Good bye
    </div>
  );
}
