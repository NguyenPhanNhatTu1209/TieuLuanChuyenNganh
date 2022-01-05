import React from "react";
import { useDispatch } from "react-redux";
import UpdateCardProduct from "../UpdateCardProduct";

const ShopProduct = (props: { data?: Array<any> }) => {
  const dispatch = useDispatch();

  return (
    <div className="row">
      {props.data?.map((e, i) => (
        <div className="col-md-6 col-lg-3 ftco-animate" key={i}>
          <UpdateCardProduct data={e} />
        </div>
      ))}
    </div>
  );
};

export default ShopProduct;
