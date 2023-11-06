import Nav from "@/components/nav";
import Header from "./header";

export default async function DashboardLayout({ children }) {
  return (
    <div className="flex flex-row p-3 gap-3 h-screen">
      <aside className=" max-h-screen w-20 p-5 bg-gray-3 border border-gray-2   rounded-lg sticky top-0 md:block ">
        <Nav />
      </aside>
      <main className="flex-1 bg-gray-3 border border-gray-2  rounded-lg  max-h-screen overflow-auto ">
        {/* <Header /> */}
        {children}
      </main>
    </div>
  );
}
