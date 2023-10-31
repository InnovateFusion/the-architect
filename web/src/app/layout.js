import "./globals.css";
import { Inter } from "next/font/google";
import Providers from "./providers";
import "react-toastify/dist/ReactToastify.css";
const inter = Inter({ subsets: ["latin"] });
import { Analytics } from "@vercel/analytics/react";
import Loglib from "@loglib/tracker/react";

export const metadata = {
  title: "The Architect by Innovate Fusion",
  description:
    "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>{children}</Providers>
        <Analytics />
        <Loglib
          config={{
            id: "architect",
          }}
        />
      </body>
    </html>
  );
}
