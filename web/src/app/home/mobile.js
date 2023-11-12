import Image from "next/image";
import React from "react";
import useTranslation from "next-translate/useTranslation";

function Mobile() {
  const { t } = useTranslation("common");

  return (
    <div className="mx-auto p-20" data-aos="zoom-y-out">
      <div
        className="p-4 w-full text-center bg-white rounded-lg  shadow-md sm:p-8 dark:bg-gray-800 border-gray-700 flex flex-col items-center gap-3"
        data-aos="zoom-y-out"
      >
        <div className="flex flex-wrap justify-center gap-5 md:gap-10">
          <Image
            className="border border-gray-200 border-dashed rounded-lg transform animate-float w-auto"
            src={"/mobile/mobile3.jpg"}
            width={200}
            height={200}
            alt="Element"
          />
          <Image
            className="border border-gray-200 border-dashed rounded-lg transform animate-float w-auto"
            src={"/mobile/mobile4.jpg"}
            width={200}
            height={200}
            alt="Element"
          />
          <Image
            className="border border-gray-200 border-dashed rounded-lg transform animate-float w-auto"
            src={"/mobile/mobile6.jpg"}
            width={200}
            height={200}
            alt="Element"
          />
        </div>
        <h3 className="m-4 text-3xl font-bold text-gray-900 dark:text-white">
          {t("mb_header")}
        </h3>
        <p className="mb-5 text-base text-gray-500 sm:text-lg dark:text-gray-400 max-w-2xl">
          {t("mb_header_desc")}
        </p>
        <div
          className="justify-center items-center space-y-4 sm:flex sm:space-y-0 sm:space-x-4"
          data-aos="zoom-y-out"
        >
          <a
            href="https://drive.google.com/drive/folders/16JC1FUrBXntj8RWgEG2H9kUkEz_Ultha"
            className="w-full sm:w-auto bg-gray-800 hover:bg-gray-700 focus:ring-4 focus:ring-gray-300 text-white rounded-lg inline-flex items-center justify-center px-4 py-2.5 dark:bg-gray-700 dark:hover:bg-gray-600 dark:focus:ring-gray-700"
            target="_blank"
            data-aos="zoom-y-out"
          >
            <svg
              className="mr-3 w-7 h-7"
              aria-hidden="true"
              focusable="false"
              data-prefix="fab"
              data-icon="google-play"
              role="img"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
            >
              <path
                fill="currentColor"
                d="M325.3 234.3L104.6 13l280.8 161.2-60.1 60.1zM47 0C34 6.8 25.3 19.2 25.3 35.3v441.3c0 16.1 8.7 28.5 21.7 35.3l256.6-256L47 0zm425.2 225.6l-58.9-34.1-65.7 64.5 65.7 64.5 60.1-34.1c18-14.3 18-46.5-1.2-60.8zM104.6 499l280.8-161.2-60.1-60.1L104.6 499z"
              ></path>
            </svg>
            <div className="text-left">
              <div className="mb-1 text-xs">{t("mb_a_1")}</div>
              <div className="-mt-1 font-sans text-sm font-semibold">
                {t("mb_d_1")}
              </div>
            </div>
          </a>
          <a
            href="https://drive.google.com/file/d/1x3lbl2SqyLG3XIsA_qsvx4LNwHrR0gCg/view?usp=drivesdk"
            className="w-full sm:w-auto flex bg-gray-800 hover:bg-gray-700 focus:ring-4 focus:ring-gray-300 text-white rounded-lg inline-flex items-center justify-center px-4 py-2.5 dark:bg-gray-700 dark:hover:bg-gray-600 dark:focus:ring-gray-700"
            target="_blank"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              className="lucide lucide-arrow-big-down-dash mr-3 w-7 h-7"
            >
              <path d="M15 5H9" />
              <path d="M15 9v3h4l-7 7-7-7h4V9h6z" />
            </svg>
            <div className="text-left">
              <div className="mb-1 text-xs">{t("mb_a_2")}</div>
              <div className="-mt-1 font-sans text-sm font-semibold">
                {t("mb_d_2")}
              </div>
            </div>
          </a>
        </div>
      </div>
    </div>
  );
}

export default Mobile;
