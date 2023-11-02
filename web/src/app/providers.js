"use client";
import { ThemeProvider, useTheme } from "next-themes";
import { useState, useEffect } from "react";
import { ToastContainer } from "react-toastify";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
export default function Providers({ children }) {
  const [mounted, setMounted] = useState(false);
  const { theme } = useTheme();
  const queryClient = new QueryClient();
  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return (
      <>
        <QueryClientProvider client={queryClient}>
          {children}
        </QueryClientProvider>
        <ToastContainer theme={theme} />;
      </>
    );
  }

  return (
    <ThemeProvider attribute="class">
      <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
      <ToastContainer theme={theme} />
    </ThemeProvider>
  );
}
