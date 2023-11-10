import { stripe } from "@/lib/stripe";
import { NextResponse } from "next/server";


export async function POST(req) {
  const body = (await req.json());
  const origin = req.headers.get("origin") || "http://localhost:3000";

  // if user is logged in, redirect to thank you page, otherwise redirect to signup page.
  const success_url = !body.customerId
    ? `${origin}/dashboard?session_id={CHECKOUT_SESSION_ID}`
    : `${origin}/dashboard?session_id={CHECKOUT_SESSION_ID}`;

  try {
    const session = await stripe.checkout.sessions.create({
      // if user is logged in, stripe will set the email in the checkout page
      customer: body.customerId,
      mode: "subscription", // mode should be subscription
      line_items: [
        // generate inline price and product
        {
          price_data: {
            currency: "usd",
            recurring: {
              interval: body.interval,
            },
            unit_amount: body.amount,
            product_data: {
              name: body.plan,
              description: body.planDescription,
            },
          },
          quantity: 1,
        },
      ],
      success_url: success_url,
      cancel_url: `${origin}/subscribe?session_id={CHECKOUT_SESSION_ID}`,
    });
    return NextResponse.json(session);
  } catch (error) {
    if (error) {
      const { message } = error;
      return NextResponse.json({ message }, { status: error.statusCode });
    }
  }
}
export async function GET(req) {
  return NextResponse.json({ checkout: "stripe" });
}