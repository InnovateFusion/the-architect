"use client";
import DesignList from "./designs";
import Tags from "../../dashboard/designs/tags";

export default function Page() {
  return (
    <div className="block">
      <Tags />
      <DesignList />
    </div>
  );
}
