import Header from "../home/header";
export default function AuthLayout({ children }) {
  return (
    <main className="grow">
      <Header />
      {children}
    </main>
  );
}
