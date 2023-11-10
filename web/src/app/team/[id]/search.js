"use client";

import { SearchCheck } from "lucide-react";
import { usePathname, useRouter } from "next/navigation";
import { useTransition } from "react";
import React, { useState } from "react";
import { Card } from "@tremor/react";
import UsersTable from "./table";

export default function Search({ disabled, users }) {
  const { replace } = useRouter();
  const pathname = usePathname();
  const [isPending, startTransition] = useTransition();
  const [filteredItems, setFilteredItems] = useState(users);

  const [searchTerm, setSearchTerm] = useState("");

  const handleChange = (term) => {
    const searchQuery = term.toLowerCase();
    setSearchTerm(searchQuery);

    const filteredList = users.filter((item) => {
      const itemFirst = item.firstName.toLowerCase();
      const itemLast = item.lastName.toLowerCase();
      const itemEmail = item.email.toLowerCase();
      return (
        itemFirst.includes(searchQuery) ||
        itemLast.includes(searchQuery) ||
        itemEmail.includes(searchQuery)
      );
    });

    setFilteredItems(filteredList);
    const params = new URLSearchParams(window.location.search);
    if (term) {
      params.set("q", term);
    } else {
      params.delete("q");
    }

    // startTransition(() => {
    //   replace(`${pathname}?${params.toString()}`);
    // });
  };

  return (
    <div className="w-full md:w-1/2 ">
      <div className="relative mt-5 max-w-md">
        <label htmlFor="search" className="sr-only">
          Search
        </label>
        <div className="rounded-md shadow-sm">
          <div
            className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
            aria-hidden="true"
          >
            <SearchCheck
              className="mr-3 h-4 w-4 text-gray-400"
              aria-hidden="true"
            />
          </div>
          <input
            type="text"
            name="search"
            id="search"
            disabled={disabled}
            className="h-10 block w-full rounded-md border border-gray-200 pl-9 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
            placeholder="Search by name or emain and invite new team member..."
            spellCheck={false}
            onChange={(e) => handleChange(e.target.value)}
          />
        </div>

        {isPending && (
          <div className="absolute right-0 top-0 bottom-0 flex items-center justify-center">
            <svg
              className="animate-spin -ml-1 mr-3 h-5 w-5 text-gray-700"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                className="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
              />
              <path
                className="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
              />
            </svg>
          </div>
        )}
      </div>
      {filteredItems && filteredItems.length > 0 ? (
        <Card className="mt-6 rounded-lg max-h-[430px] overflow-y-auto  z-1 overflow-x-hidden">
          <UsersTable users={filteredItems} />
        </Card>
      ) : (
        <p>Try Searching for users using their Name or Email.</p>
      )}
    </div>
  );
}
