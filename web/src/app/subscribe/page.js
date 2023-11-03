export const metadata = {
  title: "The Architect by Innovate Fusion",
  description:
    "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
};

import Header from "../home/header";
import Footer from "../home/footer";
import Pricing from "./pricing";

export default function Home() {
  return (
    <>
      <Header />
      <Pricing />
      <Footer />
    </>
  );
}
