export default function Skeleton(){
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map(
      (item, index) => (
        <div
          key={index}
          className="h-64 rounded-2xl shadow-lg flex flex-col sm:flex-row gap-5 select-none "
        >
          <div className="h-full w-full rounded-xl bg-gray-300 dark:bg-gray-100 animate-pulse"></div>
        </div>
      )
    );
}