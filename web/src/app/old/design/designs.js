import React, { useEffect, useState } from "react";
import designsStore from "../../../store/store";
import DesignCard from "./DesignCard";

function DesignList() {
  const { designs, fetchDesigns, isLoading } = designsStore();

  useEffect(() => {
    fetchDesigns();
  }, [designs]);

  return (
    <div className="columns-1 sm:columns-2 md:columns-2 lg:columns-3 gap-4 space-y-4 py-14 px-2">
      {!isLoading
        ? designs?.map((item) => <DesignCard item={item} key={item.id} />)
        : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((item, index) => (
            <div
              key={index}
              className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none "
            >
              <div className="h-full w-full rounded-xl bg-gray-100 animate-pulse"></div>
            </div>
          ))}
    </div>
  );
}

export default DesignList;
