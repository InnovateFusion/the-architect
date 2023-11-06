import Header from "./header";

export default async function TeamLayout({ children }) {
  return (
    <div className="h-full">
      <Header />
      {children}
    </div>
  );
}
