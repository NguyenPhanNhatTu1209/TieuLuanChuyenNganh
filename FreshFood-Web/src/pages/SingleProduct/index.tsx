import React from "react";
import { useParams } from "react-router";
import HeroCommon from "../../components/HeroCommon";
import ProductDetail from "./components/ProductDetail";
import RelativeProduct from "./components/RelativeProduct";

interface Props {}

const SingleProductPage = (props: Props) => {
  const param = useParams<any>();
  console.log(param);
  return (
    <div>
      <HeroCommon />
      <ProductDetail id={param.id} />
      <RelativeProduct />
    </div>
  );
};

export default SingleProductPage;
