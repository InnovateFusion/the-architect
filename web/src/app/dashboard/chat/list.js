import Image from "next/image";
import React from "react";

function List() {
  return (
    <div>
      <div class="bg-white">
        <div class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
          <h2 class="text-2xl font-bold tracking-tight text-gray-900">
            Inspiration for your home office
          </h2>
          <div class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
            {[1, 2, 3, 4, 5, 6, 7].map((item, index) => {
              return (
                <div class="group relative" key={index}>
                  <div class={`aspectw-${index%2 == 0 ? "full" : "1/2"} overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80`}>
                    <Image
                      width={200}
                      height={200}
                      src="https://tailwindui.com/img/ecommerce-images/product-page-01-related-product-01.jpg"
                      alt="Front of men&#039;s Basic Tee in black."
                      class="h-full w-full object-cover object-center lg:h-full lg:w-full"
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
