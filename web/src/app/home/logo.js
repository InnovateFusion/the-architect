import Image from "next/image";
import Link from "next/link";

export default function Logo({ x, t }) {
  return (
    <Link href="/" className="flex p-2 items-center" aria-label="Cruip">
      <Image width={40} height={40} alt="logo" src={"/logo.svg"} />
      {!x && <Image width={80} height={80} alt="logo" src={"/if.png"} />}
      {t && (
        <div className="font-bold text-bold p-1 rounded-md focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm text-[#006c9c] capitalize">
          The Architect
        </div>
      )}
    </Link>
  );
}
