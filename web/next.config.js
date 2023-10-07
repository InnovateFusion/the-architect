/** @type {import('next').NextConfig} */
const nextConfig = {
  // add image domain for next/image
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "tecdn.b-cdn.net",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "tailwindui.com",
        port: "",
        pathname: "/**",
      },
    ],
  },
};

module.exports = nextConfig;
