import React from "react";
import HeroWrap from "./components/HeroWrap";
import CartInfo from "./components/CartInfo";

interface CartProps {}

export const Cart = (props: CartProps) => {
  return (
    <div>
      <HeroWrap />
      <CartInfo />
    </div>
  );
};
