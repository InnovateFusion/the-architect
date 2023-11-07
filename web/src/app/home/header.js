"use client"
import ThemeToggle from "@/components/theme-toggle";
import Logo from "./logo";
import Language from "./language";
import Image from "next/image";
import useTranslation from "next-translate/useTranslation";
import { useSearchParams } from "next/navigation";

const Header = () => {
  const searchParams = useSearchParams()
  const lang = searchParams.get("lang");

  return (
    <header className="max-w-6xl mx-auto w-full pt-4 bg-transparent gap-2 flex flex-row justify-between items-center px-4">
      <div className="flex items-center gap-3">
        <Logo x={1} t={1} />
      </div>
      <div className="flex items-center gap-3">
        <ThemeToggle />
        <Image
          src={`/flags/${lang || "en"}.svg`}
          width={20}
          height={20}
          alt={lang}
          className="w-10 md:20"
        />
        <Language />
      </div>
    </header>
  );
};

export default Header;
