import Image from "next/image";
import Link from "next/link";

export default function Logo() {
  return (
    <Link href="/" className="block" aria-label="Cruip">
      <Image width={40} height={40} alt="logo" src={"/logo.svg"} />
    </Link>
  );
}
