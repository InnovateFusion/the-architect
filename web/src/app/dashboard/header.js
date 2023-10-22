import Image from "next/image";
import Link from "next/link";

const Header = () => {
  const handleLogout = () => {
    console.log("logout");
    localStorage.removeItem("token");
    localStorage.removeItem("userId");
    window.location.reload();
  };
  return (
    <header className="flex w-full flex-row items-center justify-between bg-gray-800 p-4 z-50 fixed">
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
            <Link href="/">Home</Link>
          </li>
          <li className="mr-6">
            <Link href="/about">About</Link>
          </li>
          <li>
            <Link href="/contact">Contact</Link>
          </li>
        </ul>
      </nav>
      <button className="text-white hover:text-gray-400" onClick={handleLogout}>
        Logout
      </button>
    </header>
  );
};

export default Header;
