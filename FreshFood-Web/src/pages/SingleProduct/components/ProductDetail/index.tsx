import React, { useState } from "react";
import { IoIosStar, IoIosStarHalf, IoIosStarOutline } from "react-icons/io";
import { useSelector } from "react-redux";
import { createCartAsync } from "../../../../apis/cart/createcart.api";
import { getDetailProductApi } from "../../../../apis/product/getdetailproduct.api";
import { selectCurrentUser } from "../../../../features/auths/slice/selector";
import { moneyFormater } from "../../../../utils/moneyFormater";
import { notifyError, notifySuccess } from "../../../../utils/notify";
const ProductDetail = (props: { id: string }) => {
  const [product, setProduct] = useState<any>({});
  const user = useSelector(selectCurrentUser);
  const [quantity, setQuantity] = useState<any>(1);
  const handleAddToCart = async () => {
    if (!user) {
      notifyError("Bạn phải đăng nhập");
    } else if (user.role === 0) {
      const result = await createCartAsync({
        productId: props.id,
        quantity: quantity,
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
  React.useEffect(() => {
    window.scrollTo(0, 0);

    (async () => {
      const result = await getDetailProductApi({
        id: props?.id,
      });
      const { data } = result;
      console.log(data);
      setProduct(data);
    })();
  }, [props?.id]);

  const renderImage = (image: Array<string>) => {
    console.log("renderImage", image);
    if (typeof image === "undefined") return "";
    return image[0];
  };

  const renderStar = (star: number) => {
    const array = [];
    const a = Math.floor(star);
    const b = star - a;
    for (let i = 1; i <= a; i++) {
      array.push(<IoIosStar />);
    }
    if (b > 0) {
      array.push(<IoIosStarHalf />);
    }
    for (let i = Math.ceil(star); i < 5; i++) {
      array.push(<IoIosStarOutline />);
    }
    return array.map((item: any) => item);
  };
  return (
    <div>
      <section className="ftco-section">
        <div className="container">
          <div className="row">
            <div className="col-lg-6 mb-5 ftco-animate">
              <a className="image-popup">
                <img
                  src={renderImage(product.image)}
                  className="img-fluid"
                  alt="Colorlib Template"
                />
              </a>
            </div>
            <div className="col-lg-6 product-details pl-md-5 ftco-animate">
              <h3>{product?.name}</h3>

              <p className="price">
                <span>{moneyFormater(product?.price)}</span>
              </p>
              <p>{product?.detail}</p>
              <div className="row mt-4">
                <div className="col-md-6">
                  <div className="form-group d-flex">
                    <div className="select-wrap">
                      <div className="icon">
                        <span className="ion-ios-arrow-down"></span>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="w-100"></div>
                <div className="input-group col-md-6 d-flex mb-3">
                  <input
                    type="number"
                    onKeyDown={(e: any) => {
                      e.preventDefault();
                    }}
                    id="quantity"
                    name="quantity"
                    className="form-control input-number"
                    defaultValue={quantity}
                    min="1"
                    max={product.quantity}
                    onChange={(e: any) => setQuantity(e.target.value)}
                  />
                </div>
                <div className="w-100"></div>
                <div className="col-md-12">
                  <p>{product.weight} kg/each</p>
                  <p>{product.quantity} available</p>
                </div>
              </div>
              {renderStar(product.starAVG)}
              <p></p>
              <p>
                <a
                  onClick={handleAddToCart}
                  className="btn btn-primary py-3 px-5"
                >
                  Add to Cart
                </a>
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default ProductDetail;
