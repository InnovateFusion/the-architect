import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs) {
  return twMerge(clsx(inputs));
}

export function Capitalize(str) {
  return str?.charAt(0).toUpperCase() + str?.slice(1);
}