"use client";
import Image from "next/image";
import React, {useEffect, useState} from "react";
import Link from "next/link";
function List() {

  const [data, setData] = useState([]);
  const userId = 'b14ad8b5-7103-4de0-8e09-6c8b4516f41c'; // replace with the actual user id
  
  useEffect(() => {

    const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTczMjcyMzEsImVtYWlsIjoiYXNlckBnbWFpbC5jb20iLCJpZCI6ImIxNGFkOGI1LTcxMDMtNGRlMC04ZTA5LTZjOGI0NTE2ZjQxYyIsImZpcnN0X25hbWUiOiJhc2VyIiwibGFzdF9uYW1lIjoiaGFpbHUifQ.HUF7D-gonOy0ONlYfIdIy8L_5a_5UHVVBORlEjAM5M0'
    const url = `https://the-architect.onrender.com/api/v1/users/b14ad8b5-7103-4de0-8e09-6c8b4516f41c/posts`;
  
    fetch(url,
      {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })

      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        setData(data);
  
      })
      .catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
      });

  }, []);


  return (
    <div>
      <div className="">
        <div className="mx-auto px-4 py-16 sm:px-6 sm:py-6 lg:px-8">
          <h2 className="text-2xl font-bold tracking-tight ">
            My Designs
          </h2>
          <div className="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
            {data.map((item, index) => {
              return (
                <div className="group relative" key={index}>
                  <div
                    className={`aspectw-${
                      index % 2 == 0 ? "full" : "1/2"
                    } overflow-hidden rounded-md bg-gray-200 lg:aspect-none group-hover:opacity-75 lg:h-80`}
                  >
                     <Link href={`/chat/${userId}`}>
                   
                      <Image
                          width={200}
                          height={200}
                          src="/house.jpg"
                          alt="Front of men&#039;s Basic Tee in black."
                          className="h-full w-full object-cover object-center lg:h-full lg:w-full"
                        />    
                     </Link>
                   
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
