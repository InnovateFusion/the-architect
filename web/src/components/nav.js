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
export const dashboardConfig = {
  sidebarNav: [
    {
      title: "Home",
      href: "/dashboard",
      icon: "home",
    },
    {
      title: "Designs",
      href: "/dashboard/designs",
      icon: "clip",
    },
    {
      title: "Projects",
      href: "/dashboard/projects",
      icon: "folder",
    },
    {
      title: "Tools",
      href: "/dashboard/tools",
      icon: "brush",
    },
    {
      title: "Draw",
      href: "/dashboard/tools?model=controlNet",
      icon: "drafting",
    },
    {
      title: "My Designs",
      href: "/dashboard/my",
      icon: "mine",
    },
  ],
};

export default function Nav() {
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
    <div className="flex flex-col  gap-5 h-full">
      <h1 className="font-medium text-lg">
        <Link href="/">
          <Image src="/logo.svg" alt="logo" width={40} height={40} priority />
        </Link>
      </h1>
      <nav className="flex flex-col  flex-1 gap-2">
        {dashboardConfig.sidebarNav.map((link, i) => {
          const Icon = Icons[link.icon];
          return (
            <Link
              href={link.href}
              className={cn(
                "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors py-2 text-sm px-2 flex-row gap-2  ",
                pathname === link.href ? "bg-gray-2" : ""
              )}
              key={i}
            >
              <Icon size={40} />
              {/* {link.title} */}
            </Link>
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
    <Menu>
      <Menu.Items>
        <Menu.Item>
          {({ active, close }) => (
            <Link
              className={cn(
                "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2",
                pathname === "/dashboard/my" ? "bg-gray-2" : ""
              )}
              onClick={close}
              href="/dashboard/my"
            >
              <Brush />
            </Link>
          )}
        </Menu.Item>
        <Menu.Item>
          {({ active, close }) => (
            <Link
              className={cn(
                "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2",
                pathname === "/dashboard/profile" ? "bg-gray-2" : ""
              )}
              onClick={close}
              href="/dashboard/profile"
            >
              <User2 />
            </Link>
          )}
        </Menu.Item>
        <Menu.Item>
          {({ active, close }) => <ThemeToggle onClick={close} />}
        </Menu.Item>
        <Menu.Item>
          {({ active, close }) => (
            <div
              className={cn(
                "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2"
              )}
              onClick={handleLogout}
            >
              <Power />
            </div>
          )}
        </Menu.Item>
      </Menu.Items>

      <Menu.Button>
        <User size={30} />
      </Menu.Button>
    </Menu>
  );
}
