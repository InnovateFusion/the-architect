"use client";
import { Brush, PowerIcon, Power, User, User2 } from "lucide-react";
import { Menu } from "@headlessui/react";

import { cn } from "@/utils/utils";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { Icons } from "@/utils/icons";
import ThemeToggle from "@/components/theme-toggle";
import Image from "next/image";
import { toast } from "react-toastify";
import PopOver from "./popOver";
import { Button } from "@tremor/react";
export const dashboardConfig = {
  sidebarNav: [
    {
      title: "Home",
      href: "/team",
      icon: "home",
    },
    {
      title: "Teams",
      href: "/team/designs",
      icon: "clip",
    },
    {
      title: "Create Team",
      href: "/team/create",
      icon: "folder",
    },
    {
      title: "Design",
      href: "/team/chat",
      icon: "drafting",
    },
    {
      title: "Team Chat",
      href: "/team/socket",
      icon: "brush",
    },
    {
      title: "Profile",
      href: "/team/profile",
      icon: "mine",
    },
  ],
};

export default function TeamNav() {
  const pathname = usePathname();
  const router = useRouter();
  const handleLogout = () => {
    console.log("logout");
    localStorage.removeItem("token");
    localStorage.removeItem("userId");
    toast.success("See You Again");
    router.push("/auth/logout");
  };
  return (
    <div className="flex flex-col gap-5 h-full">
      <h1 className="font-medium text-lg">
        <Link href="/" className="flex gap-3">
          <Image
            src="/logo.svg"
            alt="logo"
            width={40}
            height={40}
            priority
            className="w-auto"
          />
          <h3 className="text-green-500 font-extralight font-gagalin hidden md:block">
            The <br />
            Architect
          </h3>
        </Link>
      </h1>
      <PopOver />
      <nav className="flex flex-col  flex-1 gap-2">
        {dashboardConfig.sidebarNav.map((link, i) => {
          const Icon = Icons[link.icon];
          return (
            <div className="flex" key={i}>
              <Link
                href={link.href}
                className={cn(
                  " h-10 w-full flex justify-start items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors py-2 text-sm px-2 flex-row gap-2  ",
                  pathname === link.href ? "bg-gray-2" : ""
                )}
              >
                <Icon size={40} className="p-2" />
                <div className="hidden md:block">{link.title}</div>
              </Link>
            </div>
          );
        })}
      </nav>

      <div className="w-full flex-row justify-end gap-y-2">
        <MyDropdown pathname={pathname} handleLogout={handleLogout} />
      </div>
    </div>
  );
}

function MyDropdown({ pathname, handleLogout }) {
  return (
    <div className="flex md:flex-row flex-col items-center justify-between">
      <Link
        className={cn(
          "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2",
          pathname === "/dashboard/profile" ? "bg-gray-2" : ""
        )}
        onClick={close}
        href="/team/profile"
      >
        <User2 />
      </Link>

      <ThemeToggle onClick={close} />

      <div
        className={cn(
          "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2"
        )}
        onClick={handleLogout}
      >
        <Power />
      </div>
    </div>
  );
}
