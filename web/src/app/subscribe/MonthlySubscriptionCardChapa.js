// components/MonthlySubscriptionCard.tsx
"use client";

import { useRouter } from "next/navigation";

// import { loadStripe } from "@stripe/stripe-js";

const ChapaMonthlySubscriptionCard = ({ plan }) => {
  const router = useRouter();

  const handleClick = async () => {
    if (plan == "Enterprise") {
      router.push("mailto:contact@thearc.tech");
      return;
    }
    // step 1: load stripe
    // const STRIPE_PK = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
    // const stripe = await loadStripe(STRIPE_PK);

    // step 2: define the data for monthly subscription
    const body = {
      interval: "month",
      amount: plan == "Starter" ? 600 : 1800,
      plan: "monthly",
      planDescription: `Subscribe for $ ${
        plan == "Starter" ? 599.99 : 1799.99
      } Monthly. Best option for personal use & for your next design project.`,
    };

    // step 3: make a post fetch api call to /checkout-session handler
    const result = await fetch("/api/v1/checkout/chapa", {
      method: "POST",
      body: JSON.stringify(body, null),
      headers: {
        "content-type": "application/json",
      },
    });

    // step 4: get the data and redirect to checkout using the sessionId
    if (result.status == 200) {
      const data = await result.json();
      router.push(data?.data?.checkout_url);
    }
  };
  return (
    <div className=" items-center rounded-md p-8 flex flex-col gap-2 ">
      <h2 className="text-xl font-bold">
        {plan != "Enterprise" ? "Monthly Subscription" : "Customized"}
      </h2>
      {plan != "Enterprise" ? (
        <p className="">${plan == "Starter" ? 9.99 : 29.99} per month</p>
      ) : (
        "based on your needs."
      )}
      <button
        onClick={() => handleClick()}
        className="border  rounded-md w-full transition-colors bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:ring-primary-200 text-sm px-5 py-2.5 text-center  dark:focus:ring-primary-900 hover:bg-blue-600 bg-blue-500 font-extrabold"
      >
        {plan != "Enterprise" ? "Subscribe" : "Contact Us"}
      </button>
    </div>
  );
};
export default ChapaMonthlySubscriptionCard;
