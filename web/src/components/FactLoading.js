import React, { useState, useEffect } from "react";

const LoadingComponent = () => {
  const facts = [
    "Did you know that honey never spoils?",
    "Ants can lift up to 50 times their body weight.",
    "The Eiffel Tower can be 15 cm taller during the summer due to expansion of the iron.",
    "Bananas are berries, but strawberries are not.",
    "There is enough gold in the Earth's core to coat the planet in 1.5 feet of the precious metal.",
  ];

  const [loading, setLoading] = useState(true);
  const [randomFact, setRandomFact] = useState("");

  useEffect(() => {
    setTimeout(() => {
      const randomIndex = Math.floor(Math.random() * facts.length);
      setRandomFact(facts[randomIndex]);
    }, 5000);
  }, [loading, facts]);

  return (
    <div className="w-max">
      {" "}
      <h1 className="animate-typing overflow-hidden whitespace-nowrap border-r-4 border-r-white pr-5 font-bold">
        {randomFact}
      </h1>
      <Typing randomFact={randomFact} />
    </div>
  );
};

const Typing = (randomFact) => {
  <h1 className="animate-typing overflow-hidden whitespace-nowrap border-r-4 border-r-white pr-5 font-bold">
    {randomFact}
  </h1>;
};

export default LoadingComponent;
