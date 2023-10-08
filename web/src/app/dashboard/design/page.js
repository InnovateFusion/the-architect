"use client";
import DesignListList from "./designs";
import Tags from "./tags";

export default function Page() {
  return (
    <div className="block">
      <Tags />
      <DesignListList />
    </div>
  );
}
