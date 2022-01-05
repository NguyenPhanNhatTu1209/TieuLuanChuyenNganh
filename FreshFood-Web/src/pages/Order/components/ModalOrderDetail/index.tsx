import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useSelector } from "react-redux";
import { Rating } from "react-simple-star-rating";
import { createRatingApi } from "../../../../apis/rate/createRating.api";
import { ButtonSpinner } from "../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../components/Modal";
import { selectDetailOrder } from "../../../../features/order/slice/selector";
import { moneyFormater } from "../../../../utils/moneyFormater";
import { notifyError, notifySuccess } from "../../../../utils/notify";

interface Props {
  cancel: Function;
  open: boolean;
}

const ModalOrderDetail = (props: Props) => {
  const { t, i18n } = useTranslation();
  const order = useSelector(selectDetailOrder);

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
                <div className="col-md-5" style={{ height: "300px" }}>
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
                    {order?.status === 3 && (
                      <RatingForm
                        orderId={order._id}
                        productId={item.productId}
                      />
                    )}
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

const RatingForm = (props: { orderId: string; productId: string }) => {
  const [rating, setRating] = useState(100);
  const { t, i18n } = useTranslation();
  const arr = [
    `${t("order.Rating.Level1")}`,
    `${t("order.Rating.Level2")}`,
    `${t("order.Rating.Level3")}`,
    `${t("order.Rating.Level4")}`,
    `${t("order.Rating.Level5")}`,
    `${t("order.Rating.Level6")}`,
    `${t("order.Rating.Level7")}`,
    `${t("order.Rating.Level8")}`,
    `${t("order.Rating.Level9")}`,
    `${t("order.Rating.Level10")}`,
  ];

  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm();

  const submit = async (data: any, e: any) => {
    e.preventDefault();
    data.orderId = props.orderId;
    data.productId = props.productId;
    data.star = rating / 20;
    console.log(data);
    const Arr = [data];
    const result = await createRatingApi(Arr);
    if (result.statusCode === 200) {
      notifySuccess("Đánh giá thành công");
      reset();
    } else {
      notifyError("Đánh giá thất bại, sản phẩm đã được đánh giá");
    }
  };

  const handleRating = (rate: number) => {
    setRating(rate);
    // other logic
  };

  return (
    <>
      {" "}
      <form onSubmit={handleSubmit(submit)}>
        <span>{t("order.Modal.Title4")}</span>
        <Rating
          initialValue={rating}
          onClick={handleRating}
          ratingValue={rating} /* Available Props */
          allowHalfIcon
          tooltipArray={arr}
          showTooltip
        />
        <p></p>
        <div className="form-group">
          <textarea
            defaultValue=""
            {...register("content")}
            className="form-control"
            id="exampleFormControlTextarea1"
            placeholder={t("order.Modal.Input")}
          ></textarea>
        </div>
        <button
          type="submit"
          className="btn btn-success"
          style={{ backgroundColor: "#82ae46" }}
        >
          {!isSubmitting ? t("order.Modal.Button") : <ButtonSpinner />}
        </button>
      </form>
    </>
  );
};
export default ModalOrderDetail;
