"use client";
import { useRouter } from "next/navigation";
import React, { useEffect } from "react";

import { toast } from "react-toastify";

export default function App() {
  const router = useRouter();
  const notify = () => toast.success("See You Again");
  const handleLogout = () => {
    console.log("logout");
    localStorage.removeItem("token");
    localStorage.removeItem("userId");
    router.push("/home");
  };
  useEffect(() => {
    handleLogout();
    notify();
  }, []);

  return (
    <div className="flex align-center items-center justify-center h-full text-5xl">
      Good bye
    </div>
  );
}
