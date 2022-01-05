import React from "react";
import { IoMdCart } from "react-icons/io";
import { useSelector } from "react-redux";
import { useHistory } from "react-router";
import { Link } from "react-router-dom";
import { createCartAsync } from "../../apis/cart/createcart.api";
import { selectCurrentUser } from "../../features/auths/slice/selector";
import { moneyFormater } from "../../utils/moneyFormater";
import { notifyError, notifySuccess } from "../../utils/notify";

const CardProduct = (props: { data?: any }) => {
  const history = useHistory();
  const user = useSelector(selectCurrentUser);

  const handleAddToCart = async () => {
    if (!user) {
      notifyError("Bạn phải đăng nhập");
    } else if (user.role === 0) {
      const result = await createCartAsync({
        productId: props.data?._id,
        quantity: 1,
      });
      if (result.statusCode === 200) {
        notifySuccess(`Thêm ${result.data.name} vào giỏ hàng`);
      }
    } else if (user.role === 1) {
      notifyError("Không thực hiện được");
    } else if (user.role === 2) {
      notifyError("Không thực hiện được");
    }
  };

  const handleClickSingleProduct = (id: string) => {
    history.push(`/singleproduct/${id}`);
    window.scrollTo(0, 0);
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
              onClick={handleAddToCart}
              className="
												buy-now
												d-flex
												justify-content-center
												align-items-center
												mx-1
											"
            >
              <span>
                <IoMdCart />
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CardProduct;
