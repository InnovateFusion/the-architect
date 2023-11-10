import Link from "next/link";
const Header = () => {
  return (
    <header className="shadow w-full sticky top-0 z-50 px-2 py-2 bg-transparent gap-2 backdrop-blur-sm flex flex-row justify-between md:justify-center items-center max-w-7xl mx-auto sm:px-6 lg:px-8">
      <h1 className="text-3xl font-bold leading-tight">
        <Link href="/home">My Dashboard</Link>
      </h1>
    </header>
  );
};

export default Header;
