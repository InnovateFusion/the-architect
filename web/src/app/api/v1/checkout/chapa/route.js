import { chapa } from "@/lib/chapa";
import { NextResponse } from "next/server";

export async function POST(req) {
  const body = await req.json();
  const origin = req.headers.get("origin") || "http://localhost:3000";

  // if user is logged in, redirect to thank you page, otherwise redirect to signup page.
  const success_url = !body.userId
    ? `${origin}/dashboard`
    : `${origin}/dashboard`;

  const tx_ref = await chapa.generateTransactionReference();
  const customerInfo = {
    first_name: "John",
    last_name: "Doe",
    email: "john@gmail.com",
    currency: "ETB",
    amount: "200",
    tx_ref: tx_ref,
    callback_url: "https://thearc.tech/dashboard",
    return_url: "https://thearc.tech/dashboard",
    customization: {
      title: "Test Title",
      description: "Test Description",
    },
  };

  try {
    console.log("--------")
    const session = await chapa
      .initialize(customerInfo)
      .then((response) => response)
      .catch((e) => console.log(e));
    
    console.log(session)

    return NextResponse.json(session);
  } catch (error) {
    if (error) {
      const { message } = error;
      return NextResponse.json({ message }, { status: error.statusCode });
    }
  }
}
export async function GET(req) {
  return NextResponse.json({ checkout: "Chapa" });
}
