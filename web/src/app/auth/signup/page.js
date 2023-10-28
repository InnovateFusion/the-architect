"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import React from "react";

export default function SignUp() {
  const [isLoading, setIsLoading] = React.useState(false);
  const [firstName, setfirstName] = React.useState("Bisrat");
  const [lastName, setlastName] = React.useState("Kebere");
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
    console.log("user");
    try {
      const res = await fetch(
        "https://the-architect.onrender.com/api/v1/users",
        options
      );
      if (res.status == 200) {
        const data = await res.json();
        router.push("/auth/signin");
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
              Welcome. We exist to make <u>Design</u> easier.
            </h1>
          </div>

          {/* Form */}
          <div className="max-w-sm mx-auto">
            <form>
              <div className="flex  -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block text-gray-800 text-sm font-medium mb-1"
                    htmlFor="name"
                  >
                    First Name <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="firstName"
                    type="text"
                    className="form-input w-full text-gray-800"
                    placeholder="first name"
                    value={firstName}
                    onChange={(e) => setfirstName(e.target.value)}
                    required
                  />
                </div>
                <div className="w-full px-3">
                  <label
                    className="block text-gray-800 text-sm font-medium mb-1"
                    htmlFor="name"
                  >
                    Last Name <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="lastName"
                    type="text"
                    className="form-input w-full text-gray-800"
                    placeholder="last name"
                    value={lastName}
                    onChange={(e) => setlastName(e.target.value)}
                    required
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block text-gray-800 text-sm font-medium mb-1"
                    htmlFor="email"
                  >
                    Email <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="email"
                    type="email"
                    className="form-input w-full text-gray-800"
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
                    className="block text-gray-800 text-sm font-medium mb-1"
                    htmlFor="password"
                  >
                    Password <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="password"
                    type="password"
                    className="form-input w-full text-gray-800"
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
                    className="btn text-white bg-blue-600 hover:bg-blue-700 w-full"
                    onClick={onSubmit}
                  >
                    Sign up
                  </button>
                </div>
              </div>
              <div className="text-sm text-gray-500 text-center mt-3">
                By creating an account, you agree to the{" "}
                <a className="underline" href="#0">
                  terms & conditions
                </a>
                , and our{" "}
                <a className="underline" href="#0">
                  privacy policy
                </a>
                .
              </div>
            </form>
            <div className="text-gray-600 text-center mt-6">
              Already using The Architect?{" "}
              <Link
                href="/auth/signin"
                className="text-blue-600 hover:underline transition duration-150 ease-in-out"
              >
                Sign in
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
