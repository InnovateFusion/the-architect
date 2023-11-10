import React, { useState } from "react";
import { Card } from "@tremor/react";
import UsersTable from "./table";

const SearchBar = ({ items }) => {
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredItems, setFilteredItems] = useState(items);

  const handleChange = (event) => {
    const searchQuery = event.target.value.toLowerCase();
    setSearchTerm(searchQuery);

    const filteredList = items.filter((item) => {
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
  };

  return (
    <div>
      <input
        type="text"
        placeholder="Search items..."
        value={searchTerm}
        onChange={handleChange}
      />
      {filteredItems.length > 0 ? (
        <Card className="mt-6 rounded-lg w-full md:w-1/2 max-h-[350px] overflow-y-auto overflow-x-hidden  z-1">
          <UsersTable users={filteredItems || []} />
        </Card>
      ) : (
        <p>No items found.</p>
      )}
    </div>
  );
};

export default SearchBar;
