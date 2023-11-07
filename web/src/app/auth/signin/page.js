"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import React from "react";
import { toast } from "react-toastify";
import useTranslation from "next-translate/useTranslation";

export default function SignIn() {
  const [isLoading, setIsLoading] = React.useState(false);
  const [email, setEmail] = React.useState("dev@bisrat.tech");
  const [password, setPassword] = React.useState("12345678");
  const router = useRouter();
  const { t } = useTranslation("common");

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
          toast.success(
            `Welcome back ${user.firstName} to The Architects Platform.`
          );
        } else {
          throw new Error("Invalid Token");
        }
        router.push("/dashboard");
      } else {
        throw new Error("Invalid email or password");
      }
      setIsLoading(false);
    } catch (err) {
      console.log(err);
      toast.error(err.message);
      setIsLoading(false);
    }
  }

  const [token, setToken] = React.useState(null);
  React.useEffect(() => {
    setToken(localStorage.getItem("token"));
    console.log(token);
    if (token) {
      router.push("/dashboard");
    }
  }, [token]);

  return (
    <section className="">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <div className="pt-12 pb-12 md:pt-10 md:pb-10">
          {/* Page header */}
          <div className="max-w-3xl mx-auto text-center pb-12 ">
            <h1 className="h1">
              {t("s_welcome")} <u>{t("s_welcome_1")}</u> {t("s_welcome_2")}.
            </h1>
          </div>

          {/* Form */}
          <div className="max-w-sm mx-auto">
            <form onSubmit={onSubmit}>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block   text-sm font-medium mb-1"
                    htmlFor="email"
                  >
                    {t("r_email")}
                  </label>
                  <input
                    id="email"
                    type="email"
                    className="form-input w-full  text-gray-800"
                    placeholder="Enter your email address"
                    required
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    disabled={isLoading}
                    autoComplete="email"
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <div className="flex justify-between">
                    <label
                      className="block   text-sm font-medium mb-1"
                      htmlFor="password"
                    >
                      {t("s_password")}
                    </label>
                    <Link
                      href="/auth/reset-password"
                      className="text-sm font-medium text-blue-600 hover:underline"
                    >
                      {t("s_trouble")}
                    </Link>
                  </div>
                  <input
                    id="password"
                    type="password"
                    className="form-input w-full text-gray-800 "
                    placeholder="Enter your password"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    disabled={isLoading}
                    autoComplete="current-password"
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <div className="flex justify-between">
                    <label className="flex items-center">
                      <input
                        type="checkbox"
                        className="text-gray-800 form-checkbox"
                      />
                      <span className="  ml-2">{t("s_signedin")}</span>
                    </label>
                  </div>
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mt-6">
                <div className="w-full px-3">
                  <button
                    disabled={isLoading}
                    className={`btn text-white bg-blue-600 hover:bg-blue-700 w-full disabled:bg-black ${
                      isLoading ? "bg-red-500" : ""
                    } `}
                  >
                    {isLoading ? "Signing in..." : "Sign in"}
                  </button>
                </div>
              </div>
            </form>

            <div className="  text-center mt-6">
              {t("r_ques")}
              <Link
                href="/auth/signup"
                className="text-blue-600 hover:underline transition duration-150 ease-in-out"
              >
                {t("r_action_2")}
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
