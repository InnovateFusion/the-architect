import Header from "./header";
import TeamNav from "./TeamNav";

export default async function TeamLayout({ children }) {
  return (
    <div className="flex flex-row p-3 gap-3 h-screen">
      <aside className=" max-h-screen min-w-200 p-2 md:p-5 bg-gray-3 border border-gray-2   rounded-lg sticky top-0 md:block ">
        <TeamNav />
      </aside>
      <main className="flex-1 bg-gray-3 border border-gray-2  rounded-lg  max-h-screen overflow-auto ">
        {/* <Header /> */}
        {children}
      </main>
    </div>
  );
}
