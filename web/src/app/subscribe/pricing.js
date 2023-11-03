"use client";
import { pricing } from "@/utils/constant";
import React, { useState } from "react";
import MonthlySubscriptionCard from "./MonthlySubscriptionCard";

function Pricing() {
  const [x, setx] = useState(true);
  return (
    <section className="">
      <div className="py-8 px-4 mx-auto max-w-screen-xl lg:py-16 lg:px-6">
        <div className="mx-auto max-w-screen-md text-center mb-8 lg:mb-12">
          <h2 className="mb-4 text-4xl tracking-tight font-extrabold ">
            Designed for business teams <br /> like yours
          </h2>
          <p className="mb-5 font-light text-gray-500 sm:text-xl dark:text-gray-400">
            Here at Innovate Fusion we focus on architects where technology,
            innovation, and capital can unlock long-term value and drive
            economic growth.
          </p>

          <div className="flex items-center justify-center mt-10 space-x-4">
            <span className="text-base font-medium">USD</span>
            <button
              className="relative rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              onClick={(e) => setx(!x)}
            >
              <div className="w-16 h-8 transition bg-indigo-500 rounded-full shadow-md outline-none"></div>
              <div
                className={`absolute inline-flex items-center justify-center w-6 h-6 transition-all duration-200 ease-in-out transform bg-white rounded-full shadow-sm top-1 left-1 ${
                  x ? "translate-x-0" : "translate-x-8"
                }`}
              ></div>
            </button>
            <span className="text-base font-medium">ETB</span>
          </div>
        </div>
        <div className="space-y-8 lg:grid lg:grid-cols-2 sm:gap-6 xl:gap-10 lg:space-y-0">
          {pricing.map((e, i) => (
            <div
              key={i}
              className="flex flex-col p-6 mx-auto max-w-lg text-center text-gray-900 bg-white rounded-lg border border-gray-500 shadow dark:border-gray-600 xl:p-8 dark:bg-gray-800 dark:text-white"
            >
              <h3 className="mb-4 text-2xl font-semibold">{e.name}</h3>
              <p className="font-light text-gray-500 sm:text-lg dark:text-gray-400">
                {e.description}
              </p>
              <div className="flex justify-center items-baseline my-8">
                <span className="mr-2 text-5xl font-extrabold">
                  {i == 3 ? e.price : x ? "$" + e.priceD : e.priceB + " birr"}
                </span>
                <span className="text-gray-500 dark:text-gray-400">
                  {i != 3 && "/" + e.duration}
                </span>
              </div>
              <ul role="list" className="mb-8 space-y-4 text-left">
                {e.features.map((feature, index) => (
                  <li key={index} className="flex items-center space-x-3">
                    <svg
                      className="flex-shrink-0 w-5 h-5 text-green-500 dark:text-green-400"
                      fill="currentColor"
                      viewBox="0 0 20 20"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        fillRule="evenodd"
                        d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                        clipRule="evenodd"
                      ></path>
                    </svg>
                    <span>{feature}</span>
                  </li>
                ))}
              </ul>
              <MonthlySubscriptionCard plan={e.name} />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

export default Pricing;
