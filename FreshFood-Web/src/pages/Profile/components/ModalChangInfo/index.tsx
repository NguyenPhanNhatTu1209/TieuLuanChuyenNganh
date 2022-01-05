import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useDispatch } from "react-redux";
import { updateInfomatinApi } from "../../../../apis/auths/updateinfomation.api";
import { ButtonSpinner } from "../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../components/Modal";
import { getCurrentUserAsync } from "../../../../features/auths/slice/thunk";
import { notifySuccess } from "../../../../utils/notify";
import { updateInfoSchema } from "../../../../validate/auth";
interface Props {
  cancel: Function;
  open: boolean;
}

const ModalChangeInfo = (props: Props) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm({ resolver: yupResolver(updateInfoSchema) });
  const dispatch = useDispatch();
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    const result = await updateInfomatinApi(data);
    if (result.statusCode === 200) {
      notifySuccess("Đổi thông tin thành công");
      reset();
      props.cancel();
      dispatch(getCurrentUserAsync());
    }
  };
  const { t, i18n } = useTranslation();

  return (
    <div>
      {props.open ? (
        <ModalLMS
          title={t("profile.Modal1.HeaderTitle")}
          withHeader={true}
          cancel={props.cancel}
        >
          <div className="changeInfo">
            <form onSubmit={handleSubmit(submit)} className="changInfomation">
              <p>{t("profile.Modal1.SubTitle")}</p>
              <input
                type=""
                {...register("phone")}
                id="phone"
                className="form-control"
                placeholder={t("profile.Modal1.Input1")}
              />
              <p className="text-danger">{errors.phone?.message}</p>
              <input
                type="text"
                id="name"
                {...register("name")}
                className="form-control"
                placeholder={t("profile.Modal1.Input2")}
              />
              <p className="text-danger">{errors.name?.message}</p>

              <button
                id="changeinfo"
                className="btn btn-block login-btn mb-4"
                type="submit"
                style={{ backgroundColor: "#82ae46" }}
              >
                {isSubmitting ? <ButtonSpinner /> : t("profile.Modal1.Button")}
              </button>
            </form>
          </div>
        </ModalLMS>
      ) : (
        <></>
      )}
    </div>
  );
};

export default ModalChangeInfo;
