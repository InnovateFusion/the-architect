import Link from "next/link";
import React from "react";

function Sidebar() {
  return (
    <div className="fixed hidden sm:flex h-screen bg-gray-800 w-16 flex-col items-center justify-between">
      <div className="m-5 flex flex-col">
        {["/dashboard/design", "/dashboard/draw", "/dashboard/chat"].map(
          (item, index) => {
            return (
              <Link
                className="text-white hover:text-gray-300 focus:outline-none mt-4"
                key={index}
                href={item}
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="2"
                    d="M9 5l7 7-7 7"
                  />
                </svg>
              </Link>
            );
          }
        )}
      </div>
      <div className="mb-4"></div>
    </div>
  );
}

export default Sidebar;
