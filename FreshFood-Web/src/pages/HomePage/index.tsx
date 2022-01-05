import React from "react";
import ServiceHome from "./components/serviceHome";
import HeroHome from "./components/heroHome";
import OurProduct from "./components/ourProduct";

const HomePage = () => {
  return (
    <main className="goto-here" style={{ overflow: "hidden" }}>
      <HeroHome />
      <ServiceHome />
      <OurProduct />
    </main>
  );
};
export default HomePage;
