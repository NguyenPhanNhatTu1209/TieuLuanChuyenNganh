import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { payloadGetOrderByUser } from "../../apis/order/getOrderByUser.api";
import { updateStatusOrderApi } from "../../apis/order/updateStatusOrder.api";
import { getDetailOrder } from "../../features/order/slice";
import { selectAllOrder } from "../../features/order/slice/selector";
import { getOrderByUserAsync } from "../../features/order/slice/thunk";
import empty from "../../images/empty.png";
import { moneyFormater } from "../../utils/moneyFormater";
import { notifySuccess } from "../../utils/notify";
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
  const { t, i18n } = useTranslation();

  const dispatch = useDispatch();

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
    dispatch(getOrderByUserAsync(payload));
  };

  React.useEffect(() => {
    dispatch(getOrderByUserAsync(payload));
    document.getElementById("list-0")?.classList.add("active");
  }, []);

  const renderNav = () => {
    return (
      <>
        <span
          style={{ cursor: "pointer" }}
          onClick={(event: any) => onClickMyNhan(event, 0)}
          className="list"
          id={`list-${0}`}
        >
          {t("order.Title1")}
        </span>
        <span
          style={{ cursor: "pointer" }}
          onClick={(event: any) => onClickMyNhan(event, 1)}
          className="list"
          id={`list-${1}`}
        >
          {t("order.Title2")}
        </span>
        <span
          style={{ cursor: "pointer" }}
          onClick={(event: any) => onClickMyNhan(event, 2)}
          className="list"
          id={`list-${2}`}
        >
          {t("order.Title3")}
        </span>

        <span
          style={{ cursor: "pointer" }}
          onClick={(event: any) => onClickMyNhan(event, 3)}
          className="list"
          id={`list-${3}`}
        >
          {t("order.Title4")}
        </span>

        <span
          style={{ cursor: "pointer" }}
          onClick={(event: any) => onClickMyNhan(event, 4)}
          className="list"
          id={`list-${4}`}
        >
          {t("order.Title5")}
        </span>
      </>
    );
  };

  const cancel = async (status: number, id: string) => {
    const result = await updateStatusOrderApi({ id: id, status: status });
    if (result.statusCode === 200) {
      dispatch(getOrderByUserAsync(payload));
      notifySuccess("Đổi trạng thái thành công");
    }
  };

  const userProduct = useSelector(selectAllOrder);
  return (
    <div className="orderPage container">
      <div className="orderPage-wrapper">{renderNav()}</div>
      <div className="orderPage-bottom p-4" style={{ overflow: "auto" }}>
        {userProduct?.length === 0 ? (
          <EmtyOrder />
        ) : (
          userProduct?.map((item: any, i: any) => (
            <div className="card mb-3" key={i}>
              <div
                id="order-orderCode"
                className="card-header text-white "
                style={{ backgroundColor: "#82ae46" }}
                onClick={() => handdleOpen(item)}
              >{`${t("order.OrderDetail.HeaderTitle")}${item.orderCode}`}</div>
              <div className="card-body ">
                <h5 className="card-title">{`${t("order.OrderDetail.Title1")}${
                  item.area.address
                }, ${item.area.district}, ${item.area.province}`}</h5>
                <p className="card-text">{`${t(
                  "order.OrderDetail.Title2"
                )}${moneyFormater(item.totalMoney)}`}</p>
                <p className="card-text">{`${t("order.OrderDetail.Title3")}${
                  item?.typePayment
                }`}</p>
              </div>
              {item.status === 0 ? (
                <>
                  <button
                    onClick={() => cancel(4, item._id)}
                    type="submit"
                    className="btn btn-success"
                    style={{
                      backgroundColor: "#82ae46",
                      margin: "10px",
                      width: "10%",
                    }}
                  >
                    {t("order.OrderDetail.Button")}
                  </button>
                </>
              ) : (
                <></>
              )}
            </div>
          ))
        )}
      </div>
      <ModalOrderDetail open={open} cancel={handdleCancel} />
    </div>
  );
};

const EmtyOrder = () => {
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

export default OrderPage;
