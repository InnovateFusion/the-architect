"use client";

import { useRouter } from "next/navigation";
import * as React from "react";

export function UserAuthForm({ className, ...props }) {
  const [isLoading, setIsLoading] = React.useState(false);
  const [username, setUsername] = React.useState("");
  const [password, setPassword] = React.useState("");
  const router = useRouter();

  async function onSubmit(event) {
    event.preventDefault();
    setIsLoading(true);
    const options = {
      method: "POST",
      headers: {
        "content-type": "application/json",
      },
      body: JSON.stringify({ email: username, password: password }),
    };
    try {
      console.log(username);
      console.log(password);
      const res = await fetch(
        "https://the-architect.onrender.com/api/v1/token",
        options
      );
      if (res.status == 200) {
        const user = await res.json();

        localStorage.setItem("token", user.access_token);
        router.push("/dashboard/design");
      }
      setIsLoading(false);
    } catch {
      console.log("error");
      setIsLoading(false);
    }
  }

  React.useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      router.push("/dashboard/chat");
    }
  }, []);

  return (
    <div className="grid gap-6" {...props}>
      <form onSubmit={onSubmit}>
        <div className="grid gap-2">
          <div className="grid gap-1">
            <div className="label sr-only" htmlFor="email">
              Email
            </div>
            <input
              id="email"
              placeholder="name@example.com"
              type="email"
              autoCapitalize="none"
              autoComplete="email"
              autoCorrect="off"
              disabled={isLoading}
              className="input input-bordered w-full "
              onChange={(e) => setUsername(e.target.value)}
              value={username}
            />

            <input
              id="password"
              placeholder="password"
              type="password"
              autoCapitalize="none"
              autoCorrect="off"
              disabled={isLoading}
              className="input input-bordered w-full "
              onChange={(e) => setPassword(e.target.value)}
              value={password}
            />
          </div>
          <button className="btn btn-primary m-2" disabled={isLoading}>
            {isLoading && (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
                className="w-6 h-6"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"
                />
              </svg>
            )}
            Login
          </button>
        </div>
      </form>
      <div className="relative">
        <div className="absolute inset-0 flex items-center">
          <span className="w-full border-t" />
        </div>
      </div>
    </div>
  );
}
