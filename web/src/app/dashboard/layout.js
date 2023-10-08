"use client";
import { useState } from "react";
import Sidebar from "./sidebar";
import Header from "./header";

export default function DashboardLayout({ children }) {
  return (
    <section>
      <div className="min-h-screen">
        <div className="flex">
          <Sidebar />
          <Header />
          <div className="pt-16 max-h-screen min-w-full sm:max-w-full sm:pl-16 flex  flex-wrap sm:block">
            {children}
          </div>
        </div>
      </div>
    </section>
  );
}
