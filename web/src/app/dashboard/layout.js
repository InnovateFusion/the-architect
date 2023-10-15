"use client";
import { useEffect, useState } from "react";
import Sidebar from "./sidebar";
import Header from "./header";
import { useRouter } from "next/navigation";

export default function DashboardLayout({ children }) {
  const router = useRouter();
  const [currentuser, setUser] = useState({});
  const getPosts = async () => {
    const userId = localStorage.getItem("userId");
    const token = localStorage.getItem("token");

    const url = `https://the-architect.onrender.com/api/v1/me`;

    const res = await fetch(url, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });
    if (res.status != 200) {
      localStorage.removeItem("token");
      localStorage.removeItem("userId");
      router.push("/auth");
    }
    const user = await res.json();
    setUser(user);
    console.log(user);
    console.log(currentuser);
  };

  useEffect(() => {
    getPosts();
  }, []);

  return (
    <section>
      <div className="min-h-screen">
        <div className="flex">
          <Sidebar />
          <Header />
          <div className="pt-16 max-h-screen min-w-full sm:max-w-full sm:pl-16 flex  flex-wrap sm:block">
            {children}
          </div>
        </div>
      </div>
    </section>
  );
}
