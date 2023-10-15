"use client";
import DesignList from "./designs";
import Tags from "./tags";

export default function Page() {
  return (
    <div className="block">
      <Tags />
      <DesignList />
    </div>
  );
}
