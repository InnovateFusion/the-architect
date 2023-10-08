export default function Tags() {
  return (
    <div className="flex pl-10 pb-4 items-center gap-4 fixed  bg-gray-800 z-50 w-full overflow-x-auto">
      {[
        "All",
        "Top Choice",
        "Architectural Design",
        "Interior Design",
        "Urban Planning",
        "Landscape Design",
        "Handmade Models",
        "Others",
      ].map((item, index) => {
        return (
          <div className="badge p-3 badge-outline badge-lg" key={index}>
            {item}
          </div>
        );
      })}
    </div>
  );
}
