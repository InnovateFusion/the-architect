export const metadata = {
  title: "The Architect by Innovate Fusion",
  description:
    "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
};

import Header from "./header";
import FeaturesBlocks from "./feature-blocks";
import Features from "./features";
import Hero from "./hero";
import HomeHero from "./main";
import Pricing from "./pricing";
import Mobile from "./mobile";
import Try from "./try";

export default function Home() {
  return (
    <>
      <Header />
      <HomeHero />
      <Try />
      <Hero />
      <Features />
      <FeaturesBlocks />
      <Mobile />
      <Pricing />
    </>
  );
}
