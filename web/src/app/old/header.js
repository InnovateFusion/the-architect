"use client"
import Image from "next/image";
import Link from "next/link";
import ThemeToggle from "@/components/theme-toggle";
import { useRouter } from "next/navigation";

const Header = () => {
  const router = useRouter()
  const handleLogout = () => {
    console.log("logout");
    localStorage.removeItem("token");
    localStorage.removeItem("userId");
    router.push("/auth/signin")
  };
  return (
    <header className="flex w-full flex-row items-center justify-between p-4 z-50 fixed">
      <div className="flex items-center">
        <Image
          width={40}
          height={40}
          src="/logo.svg"
          alt="Logo"
          className="h-8 mr-4"
        />
      </div>
      <nav>
        <ul className="flex items-center">
          <li className="mr-6">
            <Link href="/home">Home</Link>
          </li>
          <li className="mr-6">
            <Link href="/about">About</Link>
          </li>
          <li>
            <Link href="/contact">Contact</Link>
          </li>
        </ul>
      </nav>
      <div className="flex flex-wrap gap-5">
        <ThemeToggle />
        <button
          className=" hover:text-gray-400"
          onClick={handleLogout}
        >
          Logout
        </button>
      </div>
    </header>
  );
};

export default Header;
