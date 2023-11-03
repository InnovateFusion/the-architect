"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import React from "react";
import { toast } from "react-toastify";
import useTranslation from "next-translate/useTranslation";

export default function SignUp() {
  const [isLoading, setIsLoading] = React.useState(false);
  const [firstName, setfirstName] = React.useState("");
  const [lastName, setlastName] = React.useState("");
  const [email, setEmail] = React.useState("");
  const [password, setPassword] = React.useState("");
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
      body: JSON.stringify({
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        bio: "",
        country: "",
        image: "",
      }),
    };
    try {
      const res = await fetch(
        "https://the-architect.onrender.com/api/v1/users",
        options
      );
      if (res.status == 200) {
        const data = await res.json();
        router.push("/auth/signin");
        toast.success(
          `Welcome ${data.firstName} to The Architect \n Your Account has been Created Successfully \n Please log in using your credentials.`
        );
      } else {
        const { detail } = await res.json();
        throw new Error(detail);
      }
    } catch (err) {
      console.log(err);
      toast.error(err.message);
    }
    setIsLoading(false);
  }

  const [token, setToken] = React.useState(null);
  React.useEffect(() => {
    setToken(localStorage.getItem("token"));
    if (token) {
      router.push("/dashboard");
    }
  }, []);

  return (
    <section className="">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <div className="pt-12 pb-12 md:pt-10 md:pb-10">
          {/* Page header */}
          <div className="max-w-3xl mx-auto text-center pb-12 ">
            <h1 className="h1">
              {t("su_welcome")} <u>{t("s_welcome_1")}</u> {t("s_welcome_2")}
            </h1>
          </div>

          {/* Form */}
          <div className="max-w-sm mx-auto">
            <form>
              <div className="flex  -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block  text-sm font-medium mb-1"
                    htmlFor="name"
                  >
                    {t("su_fname")}
                    <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="firstName"
                    type="text"
                    className="form-input w-full text-gray-800 "
                    placeholder="First name"
                    value={firstName}
                    onChange={(e) => setfirstName(e.target.value)}
                    required
                  />
                </div>
                <div className="w-full px-3">
                  <label
                    className="block  text-sm font-medium mb-1"
                    htmlFor="name"
                  >
                    {t("su_lname")}
                    <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="lastName"
                    type="text"
                    className="form-input w-full text-gray-800 "
                    placeholder="Last name"
                    value={lastName}
                    onChange={(e) => setlastName(e.target.value)}
                    required
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block  text-sm font-medium mb-1"
                    htmlFor="email"
                  >
                    {t("r_email")} <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="email"
                    type="email"
                    className="form-input w-full text-gray-800 "
                    placeholder="Enter your email address"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block  text-sm font-medium mb-1"
                    htmlFor="password"
                  >
                    {t("s_password")} <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="password"
                    type="password"
                    className="form-input w-full text-gray-800 "
                    placeholder="Enter your password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mt-6">
                <div className="w-full px-3">
                  <button
                    className={`btn text-white bg-blue-500 hover:bg-blue-700 disabled:bg-black w-full`}
                    onClick={onSubmit}
                    disabled={isLoading}
                  >
                    {isLoading ? "Signing Up..." : "Sign up"}
                  </button>
                </div>
              </div>
              <div className="text-sm text-gray-500 text-center mt-3">
                {t("su_create")}
                <a className="underline" href="#0">
                  {t("su_term")}
                </a>
                {t("su_and")}
                <a className="underline" href="#0">
                  {t("su_privacy")}
                </a>
                .
              </div>
            </form>
            <div className=" text-center mt-6">
              {t("su_already")}
              <Link
                href="/auth/signin"
                className="text-blue-600 hover:underline transition duration-150 ease-in-out"
              >
                {t("su_signin")}
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
