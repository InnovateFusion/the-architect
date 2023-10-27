"use client"
import React from 'react';

function Tag({ tag, selected, onClick }) {
    const baseClasses = 'inline-block rounded-full px-3 py-1 text-sm font-semibold mr-2 mb-2';
    const selectedClasses = 'bg-blue-500 text-white';
    const unselectedClasses = 'bg-gray-200 text-gray-700 cursor-pointer hover:bg-gray-300';

    const classes = `${baseClasses} ${selected ? selectedClasses : unselectedClasses}`;

    return (
        <span className={classes} onClick={() => onClick(tag)}>
            {tag}
        </span>
    );
}

export default function TagList({selectedTags, setSelectedTags }) {
    const tags = [
      "exterior",
      "facade",
      "outdoor",
      "landscape",
      "architectural facade",
      "outdoor design",
      "interior",
      "indoor",
      "interior design",
      "space planning",
      "furniture design",
      "decor",
      "lighting",
    ];
    function handleTagClick(tag) {
        if (selectedTags.includes(tag)) {
            setSelectedTags(selectedTags.filter((t) => t !== tag));
        } else {
            setSelectedTags([...selectedTags, tag]);
        }
    }

    return (
        <div>
            {tags.map((tag) => (
                <Tag
                    key={tag}
                    tag={tag}
                    selected={selectedTags.includes(tag)}
                    onClick={handleTagClick}
                />
            ))}
        </div>
    );
}
