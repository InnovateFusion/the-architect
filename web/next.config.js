/** @type {import('next').NextConfig} */

const nextTranslate = require("next-translate-plugin");

const nextConfig = nextTranslate({
  // add image domain for next/image
  i18n: {
    locales: ["am", "en", "tr", "ao"],
    defaultLocale: "en",
  },
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "images.unsplash.com",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "res.cloudinary.com",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "http",
        hostname: "res.cloudinary.com",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "images.pexels.com",
        port: "",
        pathname: "/**",
      },
    ],
  },
});

module.exports = nextConfig;
