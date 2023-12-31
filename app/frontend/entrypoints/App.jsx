import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../pages/Home";

/**
 * App is the entry point and router of the application
 */
export default function App() {
  return (
    <>
      <Router>
        <Routes>
          <Route path="/" element={<Home />} />
        </Routes>
      </Router>
    </>
  );
}
