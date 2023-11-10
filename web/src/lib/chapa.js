import { Chapa } from "chapa-nodejs";

export const chapa = new Chapa({
  secretKey: process.env.CHAPA_SECRET_KEY,
});