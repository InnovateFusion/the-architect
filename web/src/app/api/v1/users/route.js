import { NextResponse } from "next/server";

export async function GET(req) {
  return NextResponse.json({ hi: "there" });
}

export async function POST(req) {
  return NextResponse.json({ hello: "there" });
}