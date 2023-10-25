"use client";

import { cn } from "@/utils/utils";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Icons } from "@/utils/icons";
import ThemeToggle from "@/components/theme-toggle";
import Image from "next/image";

export default function Nav() {
  const pathname = usePathname();
  const dashboardConfig = {
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
        title: "Customers",
        href: "/dashboard/customers",
        icon: "users",
      },
    ],
  };

  return (
    <div className="flex flex-col  gap-5 h-full">
      <h1 className="font-medium text-lg">
        <Image src="/logo.svg" alt="logo" width={40} height={40} />
      </h1>
      <nav className="flex flex-col  flex-1 gap-2">
        {dashboardConfig.sidebarNav.map((link, i) => {
          const Icon = Icons[link.icon];
          return (
            <Link
              href={link.href}
              className={cn(
                "py-1 text-sm px-2 rounded-lg flex flex-row gap-2 transition-colors items-center ",
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

      <div className="w-full flex justify-end">
        <ThemeToggle />
      </div>
    </div>
  );
}
