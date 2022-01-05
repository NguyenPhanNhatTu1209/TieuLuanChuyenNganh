import React from "react";
import { useDispatch } from "react-redux";
import { useHistory } from "react-router";
import { Link } from "react-router-dom";
import { getDetailProduct } from "../../../../../features/products/slice";
import img from "../../../../../images/pencil.png";
import { moneyFormater } from "../../../../../utils/moneyFormater";

const UpdateCardProduct = (props: { data?: any }) => {
  const history = useHistory();
  const dispatch = useDispatch();
  const handleClick = () => {
    dispatch(getDetailProduct(props.data));
    history.push(`/detailproduct/${props.data._id}`);
    window.scroll(0, 0);
  };

  return (
    <div className="product">
      <Link to={`/singleproduct/${props?.data?._id}`} className="img-prod">
        <img
          className="img-fluid"
          src={props.data?.image[0]}
          alt="Colorlib Template"
        />
        <div className="overlay"></div>
      </Link>
      <div className="text py-3 pb-4 px-3 text-center">
        <h3>
          <a href="#">{props.data?.name}</a>
        </h3>
        <div className="d-flex">
          <div className="pricing">
            <p className="price">
              <span>{moneyFormater(props.data?.price || 0)}</span>
            </p>
          </div>
        </div>
        <div className="bottom-area d-flex px-4">
          <div className="m-auto d-flex">
            <button
              onClick={handleClick}
              className="
												buy-now
												d-flex
												justify-content-center
												align-items-center
												mx-1
											"
            >
              <img src={img} alt="" style={{ height: "15px", width: "15px" }} />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UpdateCardProduct;
