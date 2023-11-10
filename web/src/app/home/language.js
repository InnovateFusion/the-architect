"use client";
import useTranslation from "next-translate/useTranslation";
import { useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import i18nConfig from "../../../i18n.json";

const { locales, countries } = i18nConfig;
export default function Language() {
  const searchParams = useSearchParams()
  const pathname = usePathname();
  console.log(pathname)
  const lang = searchParams.get("lang")
  //translations from common.json
  const router = useRouter();
  const [selectedLanguage, setSelectedLanguage] = useState(lang || "en"); // Default language is English
  const handleLanguageChange = async (e) => {
    setSelectedLanguage(e.target.value);
    router.push(
      `${pathname}?lang=${e.target.value}`,
      `${pathname}?lang=${e.target.value}`,
      { locale: `${e.target.value}` }
    );
  };

  return (
    <select
      id="languageSelect"
      className="mt-1 block px-3 py-2 border rounded-md shadow-sm focus:ring focus:ring-blue-300 focus:outline-none w-16 md:w-40"
      value={selectedLanguage}
      onChange={handleLanguageChange}
    >
      {locales.map((lng, idx) => {
        if (1 == 1) {
          return (
            <option key={lng} value={lng}>
              {countries[lng]?.name}
            </option>
          );
        }
      })}
    </select>
  );
}
