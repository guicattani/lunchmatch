import { useState, useEffect } from "react";

export default function Hero() {
  const [greeting, setGreeting] = useState("");

  useEffect(() => {
    fetch("/api/v1/home")
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        setGreeting(data);
      });
  }, []);

  return (
    <>
      <h1 role="heading" className="hero">
        <span className="vite smooth">Vite</span>{" "}
        <span className="rails smooth">Rails</span>
      </h1>

      <h2> {greeting && <p>{greeting}</p>}</h2>
    </>
  );
}
