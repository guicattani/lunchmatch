import React from "react";
import { act } from "react-dom/test-utils";
import { screen, waitFor } from "@testing-library/react";
import renderer from "react-test-renderer";
import ReactDOM from "react-dom/client";
import fetch from "cross-fetch";
import crossFetch from "cross-fetch";
global.fetch = fetch;

import Hero from "../Hero";

jest.mock("cross-fetch", () => {
  //Mock the default export
  return {
    __esModule: true,
    default: jest.fn(),
  };
});

let container;
beforeEach(() => {
  container = document.createElement("div");
  document.body.appendChild(container);

  crossFetch.mockResolvedValue({
    status: 200,
    json: () => "greetings",
  });
});

afterEach(() => {
  document.body.removeChild(container);
  container = null;
});

describe("Hero", () => {
  it("should show text Vite Rails", async () => {
    act(() => {
      ReactDOM.createRoot(container).render(<Hero />);
    });

    await waitFor(() => {
      expect(screen.getByText("Vite")).toBeInTheDocument();
      expect(screen.getByText("Rails")).toBeInTheDocument();
    });
  });

  it("should match the snapshot", () => {
    const tree = renderer.create(<Hero />);
    expect(tree).toMatchSnapshot();
  });
});
