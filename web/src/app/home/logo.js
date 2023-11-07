import Image from "next/image";
import Link from "next/link";

export default function Logo({ x, t, size }) {
  return (
    <Link href="/" className="flex p-2 items-center" aria-label="Cruip">
      <Image
        width={size || 40}
        height={size || 40}
        alt="logo"
        src={"/logo.svg"}
        priority
        className="w-auto"
      />
      {!x && <Image width={80} height={80} alt="logo" src={"/if.png"} />}
      {t && (
        <div className="font-bold text-bold p-1 rounded-md focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm text-[#006c9c] capitalize">
          The Architect
        </div>
      )}
    </Link>
  );
}
