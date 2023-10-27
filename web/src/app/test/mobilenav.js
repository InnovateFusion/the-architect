"use client";
import { dashboardConfig } from "@/components/nav";
import { Icons } from "@/utils/icons";
import { usePathname } from "next/navigation";

export default function MobileNav() {
  const pathname = usePathname();

  return (
    <div className="h-10 w-10  items-center justify-center p-2 flex hover:bg-gray-2 transition-colors outline-none rounded-lg md:hidden">
      <div className="btn btn-primary">holla</div>
    </div>
  );
}
