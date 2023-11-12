"use client";
import ThemeToggle from "@/components/theme-toggle";
import Logo from "./logo";
import Language from "./language";
import Image from "next/image";
import Link from "next/link";
import useTranslation from "next-translate/useTranslation";
import { useSearchParams } from "next/navigation";

const Header = () => {
  const searchParams = useSearchParams();
  const lang = searchParams.get("lang");

  return (
    <header className="max-w-6xl mx-auto w-full pt-4 bg-transparent flex flex-col px-4 gap-2">
      <div className="p-3 w-full flex flex-row justify-center items-center text-center border border-dashed font-gagalin text-lg gap-2">
        Finalist Project on{" "}
        <Link
          href="https://hacks.a2sv.org"
          className="text-blue-500 hover:underline"
        >
          A2SV Generative AI for Africa Hackaton
        </Link>
        Join Us at
        <Link
          href="https://t.me/A2SV_expo_feedback_bot"
          className="text-blue-500 hover:underline"
        >
          The A2SV Expo
        </Link>
        at Abrehot Library, Ethiopia
      </div>
      <div className="flex flex-row justify-between items-center w-full  gap-2 ">
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
      </div>
    </header>
  );
};

export default Header;
