import "server-only";

import Stripe from "stripe";

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY, {
  apiVersion: "2022-11-15",
  appInfo: {
    name: "nextjs-with-stripe-typescript-demo",
    url: "https://nextjs-with-stripe-typescript-demo.vercel.app",
  },
});
