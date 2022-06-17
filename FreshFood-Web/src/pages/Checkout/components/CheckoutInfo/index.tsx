import axios from "axios";
import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router";
import { number } from "yup/lib/locale";
import { getShipFeeApi } from "../../../../apis/address/getshipfee.api";
import { getAllCartAsync } from "../../../../apis/cart/getallcart.api";
import {
  createOrderAsync,
  payloadCreatOrder,
} from "../../../../apis/order/createorder.api";
import { SelectCustom } from "../../../../components/Select";
import { selectAllAddress } from "../../../../features/address/slice/selector";
import { getAllAddressAsync } from "../../../../features/address/slice/thunk";
import { moneyFormater } from "../../../../utils/moneyFormater";
import { notifyError, notifySuccess } from "../../../../utils/notify";
import ModalChangeAddress from "../ModalChangeAddress";

interface Props {}

const CheckoutInfo = (props: Props) => {
  const [cartList, setCartList] = useState<any>([]);
  const [shipFee, setShipFee] = useState<any>(0);
  const [open, setOpen] = useState(false);
  const [address, setAddress] = useState({
    name: "",
    phone: "",
    province: "",
    district: "",
    address: "",
  });
  const handdleOpen = () => {
    setOpen(true);
  };
  const handdleCancel = () => {
    setOpen(false);
  };
  const history = useHistory();
  React.useEffect(() => {
    (async () => {
      const result = await getAllCartAsync();
      const { data } = result;
      if (result.statusCode === 200) setCartList(data);
    })();
  }, []);

  const dispatch = useDispatch();
  React.useEffect(() => {
    dispatch(getAllAddressAsync());
  }, []);
  const addresses = useSelector(selectAllAddress);
  console.log(address);

  const createOrder = async (typeOfOrder: number) => {
    const listCartID: Array<string> = cartList.map((item: any) => item._id);
    const payload: payloadCreatOrder = {
      cartId: listCartID,
      area: {
        name: address.name,
        phone: address.phone,
        province: address.province,
        district: address.district,
        address: address.address,
      },
      note: "Dang ban lam khong lam nay duoc nha",
      typePaymentOrder: typeOfOrder,
    };

    const order = await createOrderAsync(payload);
    console.log(order);
    return order;
  };

  const handleSubmitForm = async (e: any) => {
    e.preventDefault();

    const typeOfPayment = e.target.optradio.value;
    console.log(typeOfPayment);
    if (typeOfPayment) {
      const result = await createOrder(typeOfPayment);
      console.log("123", result);
      if (typeOfPayment == 1) {
        window.open(result.data.link);
        history.push("/");
        window.scrollTo(0, 0);
      } else if (typeOfPayment == 0) {
        history.push("/");
        window.scrollTo(0, 0);
      } else if (typeOfPayment == 2) {
        window.open(result.data.link);
        history.push("/");
        window.scrollTo(0, 0);
      }
      notifySuccess("Checkout Successfully");
    } else {
      notifyError("Choose type of Payment");
    }
  };

  const handleChangeAddress = async (e: any) => {
    const item = addresses?.find((i: any) => i._id === e.value);
    setAddress(item);
    const totalWeight = cartList.reduce(
      (prev: any, current: any) => prev + current.weight,
      0
    );
    const result = await getShipFeeApi({
      province: item.province,
      district: item.district,
      weight: totalWeight,
    });
    console.log(result);
    const { data } = result;
    setShipFee(data.totalShip);
  };

  return (
    <div>
      <section className="ftco-section">
        <div className="container">
          <div className="row justify-content-center">
            <div className="col-xl-7 ftco-animate">
              <form action="#" className="billing-form">
                <h3 className="mb-4 billing-heading">Billing Details</h3>
                <div className="row align-items-end">
                  <div className="col-md-6">
                    <label>Delivery Address</label>
                    <div className=" form-group d-flex">
                      <SelectCustom
                        options={addresses}
                        handleChange={handleChangeAddress}
                      />
                      <button
                        type="button"
                        className="btn btn-primary"
                        onClick={handdleOpen}
                      >
                        +
                      </button>
                    </div>
                  </div>
                </div>

                <label>List items</label>
                <div className="cart-detail cart-total p-3 p-md-4">
                  <div className="row">
                    <div className="col-md-12 ftco-animate">
                      <div className="cart-list">
                        <table className="table">
                          <thead className="thead-primary">
                            <tr className="text-center">
                              <th>Product imgage</th>
                              <th>Product name</th>
                              <th>Weight</th>
                              <th>Price</th>
                              <th>Quantity</th>
                              <th>Total</th>
                            </tr>
                          </thead>
                          <tbody>
                            {cartList.map((e: any, i: number) => (
                              <tr className="text-center" key={i}>
                                <td className="image-prod">
                                  <div
                                    className="img"
                                    style={{
                                      backgroundImage: `url(${e.image[0]})`,
                                    }}
                                  ></div>
                                </td>

                                <td
                                  className="product-name"
                                  style={{ margin: "auto" }}
                                >
                                  <h3>{e.name}</h3>
                                </td>
                                <td className="product-weight">
                                  <h3>{e.weight} kg</h3>
                                </td>

                                <td className="price">
                                  {moneyFormater(e.cost)}
                                </td>

                                <td className="quantity">
                                  <div className="input-group mb-3">
                                    <input
                                      type="text"
                                      name="quantity"
                                      className="quantity form-control input-number"
                                      defaultValue={e.quantity}
                                      style={{ textAlign: "center" }}
                                      disabled={true}
                                    />
                                  </div>
                                </td>

                                <td className="total">
                                  {moneyFormater(e.totalCost)}
                                </td>
                              </tr>
                            ))}
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
              <ModalChangeAddress open={open} cancel={handdleCancel} />
            </div>
            <div className="col-xl-5">
              <div className="row mt-5 pt-3">
                <div className="col-md-12 d-flex mb-5">
                  <div className="cart-detail cart-total p-3 p-md-4">
                    <h3 className="billing-heading mb-4">Cart Total</h3>
                    <p className="d-flex">
                      <span>Subtotal</span>
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
                      <span>Delivery</span>
                      <span>{moneyFormater(shipFee)}</span>
                    </p>

                    <hr />
                    <p className="d-flex total-price">
                      <span>Total</span>
                      <span>
                        {cartList.length != 0
                          ? moneyFormater(
                              (cartList || []).reduce(
                                (prev: any, current: any) =>
                                  prev + current.cost * current.quantity,
                                shipFee
                              )
                            )
                          : "0 vnd"}
                      </span>
                    </p>
                  </div>
                </div>
                <div className="col-md-12">
                  <form
                    className="cart-detail p-3 p-md-4"
                    onSubmit={handleSubmitForm}
                  >
                    <h3 className="billing-heading mb-4">Payment Method</h3>
                    <div className="form-group">
                      <div className="col-md-12">
                        <div className="radio">
                          <label>
                            <input
                              value={0}
                              type="radio"
                              name="optradio"
                              className="mr-2"
                            />{" "}
                            COD
                          </label>
                        </div>
                      </div>
                    </div>
                    <div className="form-group">
                      <div className="col-md-12">
                        <div className="radio">
                          <label>
                            <input
                              value={1}
                              type="radio"
                              name="optradio"
                              className="mr-2"
                            />{" "}
                            PayPal
                          </label>
                        </div>
                      </div>
                    </div>
                    <div className="form-group">
                      <div className="col-md-12">
                        <div className="radio">
                          <label>
                            <input
                              value={2}
                              type="radio"
                              name="optradio"
                              className="mr-2"
                            />{" "}
                            VN PAY
                          </label>
                        </div>
                      </div>
                    </div>

                    <p>
                      <button className="btn btn-primary py-3 px-4">
                        Place an order
                      </button>
                    </p>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default CheckoutInfo;
