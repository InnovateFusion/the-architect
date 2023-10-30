import ThemeToggle from "@/components/theme-toggle";
import Logo from "./logo";
import Language from "./language";
import Image from "next/image";
import useTranslation from "next-translate/useTranslation";

const Header = () => {
  const { lang } = useTranslation();
  return (
    <header className="w-full pt-4 bg-transparent gap-2 flex flex-row justify-between items-center px-4 md:px-32">
      <div className="flex items-center gap-3">
        <Logo x={1} t={1} />
      </div>
      <div className="flex items-center gap-3">
        <ThemeToggle />
        <Image
          src={`/flags/${lang}.svg` || "/flags/en/svg"}
          width={40}
          height={40}
          alt={lang}
        />
        <Language />
      </div>
    </header>
  );
};

export default Header;
