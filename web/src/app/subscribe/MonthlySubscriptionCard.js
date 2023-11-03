// components/MonthlySubscriptionCard.tsx
"use client";

import { loadStripe } from "@stripe/stripe-js";

const MonthlySubscriptionCard = ({ plan }) => {
  const handleClick = async () => {
    // step 1: load stripe
    const STRIPE_PK = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
    const stripe = await loadStripe(STRIPE_PK);

    // step 2: define the data for monthly subscription
    const body = {
      interval: "month",
      amount: plan == "Starter" ? 1000 : 3000,
      plan: "yearly",
      planDescription: `Subscribe for $ ${
        plan == "Starter" ? 10.00 : 30.00
      } Monthly`,
    };

    // step 3: make a post fetch api call to /checkout-session handler
    const result = await fetch("/api/v1/checkout-sessions", {
      method: "post",
      body: JSON.stringify(body, null),
      headers: {
        "content-type": "application/json",
      },
    });

    // step 4: get the data and redirect to checkout using the sessionId
    const data = await result.json();
    const sessionId = data.id;
    stripe?.redirectToCheckout({ sessionId });
  };
  // render a simple card
  return (
    <div className="border items-center rounded-md p-8 flex flex-col gap-2 ">
      <h2 className="text-xl font-bold">Monthly Subscription</h2>
      <p className="">
        ${plan == "Starter" ? 9.99 : 29.99} per month
      </p>
      <button
        onClick={() => handleClick()}
        className="border  rounded-md w-full transition-colors bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:ring-primary-200 text-sm px-5 py-2.5 text-center  dark:focus:ring-primary-900 hover:bg-blue-600 bg-blue-500 font-extrabold"
      >
        Subscribe
      </button>
    </div>
  );
};
export default MonthlySubscriptionCard;
