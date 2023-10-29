import Link from "next/link";

import ThemeToggle from "@/components/theme-toggle";
import Logo from "./logo";

const Header = () => {
  return (
    <header className="w-full pt-4 bg-transparent gap-2 flex flex-row justify-between items-center px-4 md:px-32">
      <div className="flex items-center gap-3">
        <Logo x={1} t={1} />
      </div>
      <div className="flex items-center gap-3">
        <ThemeToggle />
      </div>
    </header>
  );
};

export default Header;
