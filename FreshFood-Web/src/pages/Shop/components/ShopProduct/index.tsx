import React, { useState } from "react";
import CardProduct from "../../../../components/CardProduct";

const ShopProduct = (props: { data?: Array<any> }) => {
  return (
    <div className="row">
      {props.data?.map((e, i) => (
        <div className="col-md-6 col-lg-3 ftco-animate" key={i}>
          <CardProduct data={e} />
        </div>
      ))}
    </div>
  );
};

export default ShopProduct;
