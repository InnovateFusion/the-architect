import { ArrowRight } from "lucide-react";
import { prompts } from "@/utils/constant";
export const Step = () => {
  return (
    <div className="px-4 py-16 mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl md:px-24 lg:px-8 lg:py-20">
      <div className="lg:py-6 lg:pr-16">
        <div className="flex">
          <div className="flex flex-col items-center mr-4">
            <div>
              <div className="flex items-center justify-center w-10 h-10 border rounded-full">
                <svg
                  className="w-4 text-gray-600 dark:text-gray-200"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  viewBox="0 0 24 24"
                >
                  <line
                    fill="none"
                    strokeMiterlimit="10"
                    x1="12"
                    y1="2"
                    x2="12"
                    y2="22"
                  />
                  <polyline
                    fill="none"
                    strokeMiterlimit="10"
                    points="19,15 12,22 5,15"
                  />
                </svg>
              </div>
            </div>
            <div className="w-px h-full bg-gray-300" />
          </div>
          <div className="pt-1 pb-8">
            <p className="mb-2 text-lg font-bold">Step 1</p>
            <p className="text-gray-700 dark:text-gray-400">
              Considering your design need and clients requirements, imagine the
              features and application aspects of the interior design
            </p>
          </div>
        </div>
        <div className="flex">
          <div className="flex flex-col items-center mr-4">
            <div>
              <div className="flex items-center justify-center w-10 h-10 border rounded-full">
                <svg
                  className="w-4 text-gray-600 dark:text-gray-200"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  viewBox="0 0 24 24"
                >
                  <line
                    fill="none"
                    strokeMiterlimit="10"
                    x1="12"
                    y1="2"
                    x2="12"
                    y2="22"
                  />
                  <polyline
                    fill="none"
                    strokeMiterlimit="10"
                    points="19,15 12,22 5,15"
                  />
                </svg>
              </div>
            </div>
            <div className="w-px h-full bg-gray-300" />
          </div>
          <div className="pt-1 pb-8">
            <p className="mb-2 text-lg font-bold">Step 2</p>
            <p className="text-gray-700 dark:text-gray-400">
              Describe your imagination in words as specific as posible to get
              the most comprehensive design that relates to your needs.
            </p>
          </div>
        </div>
        <div className="flex">
          <div className="flex flex-col items-center mr-4">
            <div>
              <div className="flex items-center justify-center w-10 h-10 border rounded-full">
                <svg
                  className="w-4 text-gray-600 dark:text-gray-200"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  viewBox="0 0 24 24"
                >
                  <line
                    fill="none"
                    strokeMiterlimit="10"
                    x1="12"
                    y1="2"
                    x2="12"
                    y2="22"
                  />
                  <polyline
                    fill="none"
                    strokeMiterlimit="10"
                    points="19,15 12,22 5,15"
                  />
                </svg>
              </div>
            </div>
            <div className="w-px h-full bg-gray-300" />
          </div>
          <div className="pt-1 pb-8">
            <p className="mb-2 text-lg font-bold">Step 3</p>
            <p className="text-gray-700 dark:text-gray-400">
              Click the Generate button and wait for the architects response.
            </p>
          </div>
        </div>
        <div className="flex">
          <div className="flex flex-col items-center mr-4">
            <div>
              <div className="flex items-center justify-center w-10 h-10 border rounded-full">
                <svg
                  className="w-6 text-gray-600 dark:text-gray-200"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <polyline
                    fill="none"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeMiterlimit="10"
                    points="6,12 10,16 18,8"
                  />
                </svg>
              </div>
            </div>
          </div>
          <div className="pt-1">
            <p className="mb-2 text-lg font-bold">
              {" "}
              Repeat and Iterate until your design needs are fulfilled.
            </p>
            <p className="text-gray-700 dark:text-gray-400" />
          </div>
        </div>
      </div>
    </div>
  );
};

export const Step2 = () => {
  return (
    <div className="px-4 items-align py-16 mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl md:px-24 lg:px-8 lg:py-20 hover:cursor-pointer">
      <div className="grid gap-6 self-align items-center ">
        Here are some prompts to start out.
      </div>
      {prompts.map((prompt, i) => (
        <div key={i} className="grid gap-6 align-center">
          <div className="flex rounded lg:p-5 lg:transition lg:duration-300 hover:bg-indigo-50 dark:hover:bg-indigo-100 hover:text-black">
            <ArrowRight size={30} className="hidden hover:block" />
            <p className="text-sm text-gray-600 dark:text-gray-400 dark:hover:text-black">
              {prompt}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
};
