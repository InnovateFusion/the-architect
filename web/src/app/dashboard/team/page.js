"use client";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

export default function Home() {
  return (
    <main className="flex h-full flex-col items-center justify-around p-24">
      <div className="bottom-0 left-10 flex-auto lg:flex  justify-center static h-auto w-auto lg:bg-none">
        <div className="flex place-items-center gap-2 p-8 lg:pointer-events-auto lg:p-0">
          <a
            className="pointer-events-none flex place-items-center gap-2 p-8 lg:pointer-events-auto lg:p-0"
            href="https://architect.bisry.me"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image
              className="w-auto"
              src="/logo.svg"
              alt="Next.js Logo"
              width={130}
              height={24}
              priority
            />
            The Architect
          </a>
        </div>
        <div></div>
        <div className="bottom-0 right-0 flex w-fulljustify-center static h-auto w-auto lg:bg-none">
          <a
            className="pointer-events-none flex place-items-center mx-8 p-8 lg:pointer-events-auto lg:p-0"
            href="https://github.com/InnovateFusion"
            target="_blank"
            rel="noopener noreferrer"
          >
            By{" "}
            <Image
              src="/if.png"
              alt="Innovate Fusion Logo"
              className=""
              width={300}
              height={40}
              priority
            />
          </a>
        </div>
      </div>
    </main>
  );
}
