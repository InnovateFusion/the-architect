"use client";
import { User } from "lucide-react";

import { cn } from "@/utils/utils";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Icons } from "@/utils/icons";
import ThemeToggle from "@/components/theme-toggle";
import Image from "next/image";
export const dashboardConfig = {
  sidebarNav: [
    {
      title: "Home",
      href: "/home",
      icon: "users",
    },
    {
      title: "Test",
      href: "/test",
      icon: "home",
    },
    {
      title: "Designs",
      href: "/test/designs",
      icon: "brush",
    },
    {
      title: "Projects",
      href: "/test/projects",
      icon: "draw",
    },
    {
      title: "Draw",
      href: "/test/draw",
      icon: "drafting",
    },
    {
      title: "Edit",
      href: "/test/edit",
      icon: "brush",
    },
    {
      title: "My Designs",
      href: "/test/my",
      icon: "drafting",
    },
    {
      title: "Profile",
      href: "/test/profile",
      icon: "brush",
    },
  ],
};

export default function Nav() {
  const pathname = usePathname();

  return (
    <div className="flex flex-col  gap-5 h-full">
      <h1 className="font-medium text-lg">
        <Image src="/logo.svg" alt="logo" width={40} height={40} priority />
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
        <ThemeToggle />
        <Link
          href={"/test/profile"}
          className={cn(
            "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors my-2",
            pathname === "/test/profile" ? "bg-gray-2" : ""
          )}
        >
          <User size={40} />
        </Link>
      </div>
    </div>
  );
}
