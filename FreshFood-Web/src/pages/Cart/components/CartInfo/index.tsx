import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { useHistory } from "react-router";
import { deleteCartAsync } from "../../../../apis/cart/deletecart.api";
import { getAllCartAsync } from "../../../../apis/cart/getallcart.api";
import { updateCartAsync } from "../../../../apis/cart/updatecart.api";
import empty from "../../../../images/empty.png";
import { moneyFormater } from "../../../../utils/moneyFormater";
import { notifySuccess } from "../../../../utils/notify";
interface Props {}

const CartInfo = (props: Props) => {
  const { t, i18n } = useTranslation();
  const [cartList, setCartList] = useState<Array<any>>([]);
  console.log(cartList);

  const handleRemoveFromCart = async (id: string, index: number) => {
    const result = await deleteCartAsync({ id });
    if (result.statusCode === 200) {
      notifySuccess("Vật phẩm được xóa");
      const newCartList = cartList.filter((item) => item._id !== id);
      setCartList(newCartList);
    }
  };

  const handleChangeQuantity = (changeQuantity: number, id: string) => {
    setCartList(
      [...cartList].map((e: any) => {
        if (e._id === id) {
          return { ...e, quantity: changeQuantity };
        } else {
          return e;
        }
      })
    );
  };

  const updateCart = async () => {
    const payload = cartList.map((item) => {
      return {
        id: item._id,
        quantity: item.quantity,
        status: item.status,
      };
    });
    const result = await updateCartAsync(payload);
    console.log(result);
  };

  React.useEffect(() => {
    (async () => {
      const result = await getAllCartAsync();
      const { data } = result;
      console.log(data);
      if (result.statusCode === 200) setCartList(data);
    })();
  }, []);

  React.useEffect(() => {
    window.addEventListener("beforeunload", alertUser);
    return () => {
      window.removeEventListener("beforeunload", alertUser);
    };
  }, []);
  const alertUser = async (e: any) => {
    e.preventDefault();
    e.returnValue = "";
    await updateCart();
  };

  React.useEffect(() => {
    return () => {
      updateCart();
    };
  });
  const history = useHistory();
  const hanldeCheckOut = () => {
    history.push("/checkout");
  };

  return (
    <div>
      <section className="ftco-section ftco-cart">
        <div className="container">
          {cartList.length === 0 ? (
            <EmtyCart />
          ) : (
            <>
              <div className="row">
                <div className="col-md-12 ftco-animate">
                  <div className="cart-list">
                    <table className="table">
                      <thead className="thead-primary">
                        <tr className="text-center">
                          <th>&nbsp;</th>
                          <th>{t("cart.CartInfo.Title1")}</th>
                          <th>{t("cart.CartInfo.Title2")}</th>
                          <th>{t("cart.CartInfo.Title3")}</th>
                          <th>{t("cart.CartInfo.Title4")}</th>
                          <th>{t("cart.CartInfo.Title5")}</th>
                          <th>{t("cart.CartInfo.Title6")}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {cartList.map((e: any, i: number) => (
                          <tr
                            id={`text-center-${i}`}
                            key={i}
                            className="text-center"
                          >
                            <td className="product-remove">
                              <button
                                onClick={() => handleRemoveFromCart(e._id, i)}
                              >
                                X
                              </button>
                            </td>
                            <td className="image-prod">
                              <div
                                className="img"
                                style={{
                                  backgroundImage: `url(${e.image[0]})`,
                                }}
                              ></div>
                            </td>

                            <td className="product-name">
                              <h3>{e.name}</h3>
                            </td>
                            <td>{e.weight} kg</td>
                            <td className="price">{moneyFormater(e.cost)}</td>

                            <td className="quantity">
                              <div className="input-group mb-3">
                                <input
                                  onKeyDown={(e: any) => e.preventDefault()}
                                  type="number"
                                  name="quantity"
                                  className="quantity form-control input-number"
                                  defaultValue={e.quantity}
                                  min="1"
                                  max="100"
                                  onChange={(event: any) =>
                                    handleChangeQuantity(
                                      event.target.value,
                                      e._id
                                    )
                                  }
                                />
                              </div>
                            </td>

                            <td className="total">
                              {moneyFormater(e.quantity * e.cost)}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div className="row justify-content-start">
                <div className="col-lg-4 mt-5 cart-wrap ftco-animate">
                  <div className="cart-total mb-3">
                    <h3>{t("cart.Banner2.Title1")}</h3>
                    <p className="d-flex">
                      <span>{t("cart.Banner2.Title2")}</span>
                      <span>
                        {cartList.length != 0
                          ? moneyFormater(
                              (cartList || []).reduce(
                                (prev: any, current: any) =>
                                  prev + current.cost * current.quantity,
                                0
                              )
                            )
                          : "0 vnd"}
                      </span>
                    </p>
                    <p className="d-flex">
                      <span>{t("cart.Banner2.Title3")}</span>
                      <span>0 VND</span>
                    </p>
                    <hr />
                    <p className="d-flex total-price">
                      <span>{t("cart.Banner2.Title4")}</span>
                      <span>
                        {cartList.length != 0
                          ? moneyFormater(
                              (cartList || []).reduce(
                                (prev: any, current: any) =>
                                  prev + current.cost * current.quantity,
                                0
                              )
                            )
                          : "0 vnd"}
                      </span>
                    </p>
                  </div>
                  <p>
                    <button
                      className="btn btn-primary py-3 px-4"
                      onClick={hanldeCheckOut}
                    >
                      {t("cart.Banner2.Button")}
                    </button>
                  </p>
                  <div>
                    {/* <button
                  onClick={updateCart}
                  className="btn btn-primary py-3 px-4"
                >
                  UpDate
                </button> */}
                  </div>
                </div>
              </div>
            </>
          )}
        </div>
      </section>
    </div>
  );
};

export const EmtyCart = () => {
  const { t, i18n } = useTranslation();
  return (
    <div className="orderPage-bottom-empty">
      <div className="orderPage-bottom-empty-image">
        <img src={empty} alt="" />
      </div>
      <h3>{t("cart.Banner1.Title3")}</h3>
    </div>
  );
};
export default CartInfo;
