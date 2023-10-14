export const metadata = {
  title: "The Architect by Innovate Fusion",
  description:
    "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
};

import FeaturesBlocks from "./feature-blocks";
import Features from "./features";
import Hero from "./hero";

export default function Home() {
  return (
    <>
      <Hero />
      <Features />
      <FeaturesBlocks />
    </>
  );
}
