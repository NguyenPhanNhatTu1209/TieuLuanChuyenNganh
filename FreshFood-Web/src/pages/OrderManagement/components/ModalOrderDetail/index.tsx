import React from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useSelector } from "react-redux";
import { createRatingApi } from "../../../../apis/rate/createRating.api";
import { ModalLMS } from "../../../../components/Modal";
import { selectDetailOrder } from "../../../../features/order/slice/selector";
import { moneyFormater } from "../../../../utils/moneyFormater";
import { notifySuccess } from "../../../../utils/notify";

interface Props {
  cancel: Function;
  open: boolean;
}

const ModalOrderDetail = (props: Props) => {
  const order = useSelector(selectDetailOrder);
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm();
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    data.orderId = order._id;
    const Arr = [data];
    const result = await createRatingApi(Arr);
    if (result.statusCode === 200) {
      notifySuccess("Đánh giá thành công");
      reset();
    }
  };
  const { t, i18n } = useTranslation();
  return (
    <div>
      {props.open ? (
        <ModalLMS
          title={t("order.Modal.HeaderTitle")}
          withHeader={true}
          cancel={props.cancel}
        >
          {order?.product?.map((item: any, i: number) => (
            <div className="card mb-3" key={i}>
              <div className="row g-0">
                <div className="col-md-5" style={{ height: "210px" }}>
                  <img
                    style={{
                      width: "100%",
                      height: "100%",
                      objectFit: "cover",
                    }}
                    src={item?.image[0]}
                    className="img-fluid rounded-start "
                    alt="..."
                  />
                </div>
                <div className="col-md-7">
                  <div className="card-body">
                    <h5 className="card-title">{item?.name}</h5>
                    <p className="card-text">{`${t("order.Modal.Title1")}${
                      item?.quantity
                    }`}</p>
                    <p className="card-text">{`${t("order.Modal.Title2")}${
                      item?.weight
                    } kg`}</p>
                    <p className="card-text">{`${t(
                      "order.Modal.Title3"
                    )}${moneyFormater(item?.price)}`}</p>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </ModalLMS>
      ) : (
        <></>
      )}
    </div>
  );
};

export default ModalOrderDetail;
