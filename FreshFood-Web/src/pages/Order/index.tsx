import React, { useState } from "react";
import { useDispatch } from "react-redux";
import {
  getGetOrderByUserApi,
  payloadGetOrderByUser,
} from "../../apis/order/getOrderByUser.api";
import { getDetailOrder } from "../../features/order/slice";
import empty from "../../images/empty.png";
import { moneyFormater } from "../../utils/moneyFormater";
import { orderStatus } from "../../utils/orderStatus";
import ModalOrderDetail from "./components/ModalOrderDetail";
import "./style.scss";

interface OrderProps {}

const payload: payloadGetOrderByUser = {
  skip: 1,
  limit: 15,
  status: 0,
};

const OrderPage = (props: OrderProps) => {
  const dispatch = useDispatch();
  const [order, setOrder] = useState<any>([]);
  const [open, setOpen] = useState(false);

  const handdleOpen = (data?: any) => {
    setOpen(true);
    dispatch(getDetailOrder(data));
  };
  const handdleCancel = () => {
    setOpen(false);
  };

  const onClickMyNhan = async (e: any, i: number) => {
    const order = document.querySelector(".list.active");
    if (!order) return;
    order.className = "list";
    e.target.className = "list active";
    payload.status = i;
    const result = await getGetOrderByUserApi(payload);
    const { data } = result;
    setOrder(data);
  };

  React.useEffect(() => {
    (async () => {
      const result = await getGetOrderByUserApi(payload);
      const { data } = result;
      setOrder(data);
    })();
    document.getElementById("list-0")?.classList.add("active");
  }, []);

  const renderNav = () => {
    return orderStatus.map((e: any, i: number) => (
      <span
        onClick={(event: any) => onClickMyNhan(event, i)}
        className="list"
        key={i}
        id={`list-${i}`}
      >
        {e.en}
      </span>
    ));
  };
  return (
    <div className="orderPage container">
      <div className="orderPage-wrapper">{renderNav()}</div>
      <div className="orderPage-bottom p-4" style={{ overflow: "auto" }}>
        {order.length === 0 ? (
          <EmtyOrder />
        ) : (
          order.map((item: any, i: any) => (
            <div
              className="card mb-3"
              onClick={() => handdleOpen(item)}
              key={i}
            >
              <div
                className="card-header text-white "
                style={{ backgroundColor: "#82ae46" }}
              >{`Order number ${item.orderCode}`}</div>
              <div className="card-body ">
                <h5 className="card-title">{`Address: ${item.area.address}, ${item.area.district}, ${item.area.province}`}</h5>
                <p className="card-text">{`Total Cost: ${moneyFormater(
                  item.totalMoney
                )}`}</p>
              </div>
            </div>
          ))
        )}
      </div>
      <ModalOrderDetail open={open} cancel={handdleCancel} />
    </div>
  );
};

const EmtyOrder = () => {
  return (
    <div className="orderPage-bottom-empty">
      <div className="orderPage-bottom-empty-image">
        <img src={empty} alt="" />
      </div>
      <h3>Empty Orders</h3>
    </div>
  );
};

export default OrderPage;
