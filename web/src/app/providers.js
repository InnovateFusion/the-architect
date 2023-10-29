"use client";
import { ThemeProvider, useTheme } from "next-themes";
import { useState, useEffect } from "react";
import { ToastContainer } from "react-toastify";
export default function Providers({ children }) {
  const [mounted, setMounted] = useState(false);
  const { theme } = useTheme();
  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return (
      <>
        {children}
        <ToastContainer />;
      </>
    );
  }

  return (
    <ThemeProvider attribute="class">
      {children}
      <ToastContainer theme={theme} />
    </ThemeProvider>
  );
}
