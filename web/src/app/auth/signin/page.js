"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import React from "react";

export default function SignIn() {
  const [isLoading, setIsLoading] = React.useState(false);
  const [email, setEmail] = React.useState("dev@bisrat.tech");
  const [password, setPassword] = React.useState("12345678");
  const router = useRouter();

  async function onSubmit(event) {
    event.preventDefault();
    setIsLoading(true);
    const options = {
      method: "POST",
      headers: {
        "content-type": "application/json",
      },
      body: JSON.stringify({ email: email, password: password }),
    };
    console.log("user");
    try {
      const res = await fetch(
        "https://the-architect.onrender.com/api/v1/token",
        options
      );
      if (res.status == 200) {
        const data = await res.json();
        localStorage.setItem("token", data.access_token);
        const result = await fetch(
          "https://the-architect.onrender.com/api/v1/me",
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${data.access_token}`,
            },
          }
        );
        if (result.status == 200) {
          const user = await result.json();
          console.log(user);
          localStorage.setItem("userId", user.id);
          localStorage.setItem("token", data.access_token);
        } else {
          throw new Error("Invalid Token");
        }
        router.push("/dashboard/design");
      } else {
        throw new Error("Invalid email or password");
      }
      setIsLoading(false);
    } catch (err) {
      console.log(err);
      setIsLoading(false);
    }
  }

  const [token, setToken] = React.useState(null);
  React.useEffect(() => {
    setToken(localStorage.getItem("token"));
    console.log(token);
    if (token) {
      router.push("/dashboard/design");
    }
  }, [token]);

  return (
    <section className="">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <div className="pt-12 pb-12 md:pt-10 md:pb-10">
          {/* Page header */}
          <div className="max-w-3xl mx-auto text-center pb-12 ">
            <h1 className="h1">
              Welcome back. We exist to make <u>Design</u> easier.
            </h1>
          </div>

          {/* Form */}
          <div className="max-w-sm mx-auto">
            <form onSubmit={onSubmit}>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block text-gray-800 text-sm font-medium mb-1"
                    htmlFor="email"
                  >
                    Email
                  </label>
                  <input
                    id="email"
                    type="email"
                    className="form-input w-full text-gray-800"
                    placeholder="Enter your email address"
                    required
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    disabled={isLoading}
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <div className="flex justify-between">
                    <label
                      className="block text-gray-800 text-sm font-medium mb-1"
                      htmlFor="password"
                    >
                      Password
                    </label>
                    <Link
                      href="/auth/reset-password"
                      className="text-sm font-medium text-blue-600 hover:underline"
                    >
                      Having trouble signing in?
                    </Link>
                  </div>
                  <input
                    id="password"
                    type="password"
                    className="form-input w-full text-gray-800"
                    placeholder="Enter your password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    disabled={isLoading}
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <div className="flex justify-between">
                    <label className="flex items-center">
                      <input type="checkbox" className="form-checkbox" />
                      <span className="text-gray-600 ml-2">
                        Keep me signed in
                      </span>
                    </label>
                  </div>
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mt-6">
                <div className="w-full px-3">
                  <button
                    disabled={isLoading}
                    className="btn text-white bg-blue-600 hover:bg-blue-700 w-full"
                  >
                    Sign in
                  </button>
                </div>
              </div>
            </form>

            <div className="text-gray-600 text-center mt-6">
              Don&apos;t you have an account?{" "}
              <Link
                href="/auth/signup"
                className="text-blue-600 hover:underline transition duration-150 ease-in-out"
              >
                Sign up
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
