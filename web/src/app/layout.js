import './globals.css'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: "The Architect by Innovate Fusion",
  description:
    "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}