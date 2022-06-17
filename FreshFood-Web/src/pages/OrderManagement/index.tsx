import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { useDispatch, useSelector } from "react-redux";
import { getGetAllOrderApi } from "../../apis/order/getAllOrder.api";
import {
  getGetOrderByUserApi,
  payloadGetOrderByUser,
} from "../../apis/order/getOrderByUser.api";
import { updateStatusOrderApi } from "../../apis/order/updateStatusOrder.api";
import { updateProductApi } from "../../apis/product/updateProduct.api";
import { ButtonSpinner } from "../../components/ButtonSpinner";
import { getDetailOrder } from "../../features/order/slice";
import { selectAllOrder } from "../../features/order/slice/selector";
import { getAllOrderAsync } from "../../features/order/slice/thunk";
import empty from "../../images/empty.png";
import { moneyFormater } from "../../utils/moneyFormater";
import { notifySuccess, notifyError } from "../../utils/notify";
import { orderStatus } from "../../utils/orderStatus";
import ModalOrderDetail from "./components/ModalOrderDetail";
import "./style.scss";

interface OrderProps {}

const OrderManagement = (props: OrderProps) => {
  const dispatch = useDispatch();
  const order = useSelector(selectAllOrder);
  const [open, setOpen] = useState(false);
  const [payload, setPayload] = useState<payloadGetOrderByUser>({
    skip: 1,
    limit: 15,
    status: 0,
  });

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
    dispatch(getAllOrderAsync({ ...payload, status: i }));
    setPayload({ ...payload, status: i });
  };

  React.useEffect(() => {
    dispatch(getAllOrderAsync(payload));
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

  const submit = async (status: number, id: string) => {
    if (status === 3 || status === 4) {
      notifyError("Failed");
    } else {
      const result = await updateStatusOrderApi({ id: id, status: status + 1 });
      if (result.statusCode === 200) {
        dispatch(getAllOrderAsync(payload));
        notifySuccess("Change Status Succesfully");
      }
    }
  };

  const cancel = async (status: number, id: string) => {
    const result = await updateStatusOrderApi({ id: id, status: status });
    if (result.statusCode === 200) {
      dispatch(getAllOrderAsync(payload));
      notifySuccess("Change Status Succesfully");
    }
  };

  return (
    <div className="orderPage container">
      <div className="orderPage-wrapper">{renderNav()}</div>
      <div className="orderPage-bottom p-4" style={{ overflow: "auto" }}>
        {order?.length === 0 ? (
          <EmtyOrder />
        ) : (
          order?.map((item: any, i: any) => (
            <div className="card mb-3" key={i}>
              <div
                onClick={() => handdleOpen(item)}
                className="card-header text-white "
                style={{ backgroundColor: "#82ae46" }}
              >{`Order number ${item.orderCode}`}</div>
              <div className="card-body ">
                <h5 className="card-title">{`Address: ${item.area.address}, ${item.area.district}, ${item.area.province}`}</h5>
                <p className="card-text">{`Total Cost: ${moneyFormater(
                  item.totalMoney
                )}`}</p>
              </div>
              <div className="card-body " style={{ marginTop: "-20px" }}>
                <button
                  onClick={() => submit(item.status, item._id)}
                  type="submit"
                  className="btn btn-success"
                  style={{ backgroundColor: "#82ae46" }}
                >
                  Next
                </button>

                {item.status === 0 || item.status === 1 || item.status === 2 ? (
                  <>
                    <button
                      onClick={() => cancel(4, item._id)}
                      type="submit"
                      className="btn btn-success"
                      style={{ backgroundColor: "#82ae46", marginLeft: "10px" }}
                    >
                      Canceled
                    </button>
                  </>
                ) : (
                  <></>
                )}
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

export default OrderManagement;
