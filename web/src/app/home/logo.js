import Image from "next/image";
import Link from "next/link";

export default function Logo() {
  return (
    <Link href="/" className="flex p-2" aria-label="Cruip">
      <Image width={40} height={40} alt="logo" src={"/logo.svg"} />
      <Image width={80} height={80} alt="logo" src={"/if.png"} />
    </Link>
  );
}
