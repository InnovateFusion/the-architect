import Image from "next/image";
import React from "react";

function List() {
  return (
    <div>
      <div className="">
        <div className="mx-auto px-4 py-16 sm:px-6 sm:py-24 lg:px-8">
          <h2 className="text-2xl font-bold tracking-tight ">
            Inspiration for your home office
          </h2>
          <div className="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
            {[1, 2, 3, 4, 5, 6, 7].map((item, index) => {
              return (
                <div className="group relative" key={index}>
                  <div
                    className={`aspectw-${
                      index % 2 == 0 ? "full" : "1/2"
                    } overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80`}
                  >
                    <Image
                      width={200}
                      height={200}
                      src="/house.jpg"
                      alt="Front of men&#039;s Basic Tee in black."
                      className="h-full w-full object-cover object-center lg:h-full lg:w-full"
                    />
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}

export default List;
