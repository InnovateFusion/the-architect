"use client";
import { useTheme } from "next-themes";
import React from "react";
import { Icons } from "@/utils/icons";
import { cn } from "@/utils/utils";

export default function ThemeToggle({ className }) {
  const { setTheme, theme } = useTheme();
  return (
    <div
      className={cn(
        "w-9 h-9 flex justify-center items-center cursor-pointer p-2 hover:bg-gray-2 rounded-lg transition-colors",
        className
      )}
      onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
    >
      <Icons.sun size={20} className="hidden dark:inline" />
      <Icons.moon size={20} className="dark:hidden" />
    </div>
  );
}
