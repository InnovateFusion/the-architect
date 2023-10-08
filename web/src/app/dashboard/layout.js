"use client"
import { useState } from "react";
import Sidebar from "./sidebar";

export default function DashboardLayout({ children }) {
  const [showSidebar, setShowSidebar] = useState(false);
  return (
    <section>
      <div className="min-h-screen">
        <div className="flex">
          {/* <MenuBarMobile setter={setShowSidebar} /> */}
          <Sidebar show={showSidebar} setter={setShowSidebar} />
          <div className="min-h-screen  sm:pl-16">{children}</div>
        </div>
      </div>
    </section>
  );
}
