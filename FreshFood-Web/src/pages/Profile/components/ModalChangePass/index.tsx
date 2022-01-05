import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useHistory } from "react-router";
import { changePassAsync } from "../../../../apis/auths/changePass.api";
import { ButtonSpinner } from "../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../components/Modal";
import { notifyError, notifySuccess } from "../../../../utils/notify";
import { changPassSchema } from "../../../../validate/auth";

interface Props {
  cancel2: Function;
  open2: boolean;
}

const ModalChangePass = (props: Props) => {
  const history = useHistory();
  const {
    register,
    handleSubmit,
    formState: { isSubmitting, errors },
  } = useForm({
    resolver: yupResolver(changPassSchema),
  });
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    return new Promise((resolve) => {
      setTimeout(async () => {
        const result = await changePassAsync({
          oldPassword: data.oldPassword,
          newPassword: data.newPassword,
        });
        if (result.statusCode === 200) {
          notifySuccess("Đổi mật khẩu thành công");
        } else if (result.statusCode === 300) {
          notifyError("Đổi mật khẩu thất bại");
        }
        resolve(true);
      }, 2000);
    });
  };

  const { t, i18n } = useTranslation();

  return (
    <div>
      {props.open2 ? (
        <ModalLMS
          title={t("profile.Modal2.HeaderTitle")}
          withHeader={true}
          cancel={props.cancel2}
        >
          <div className="d-flex justify-content-center">
            <form
              onSubmit={handleSubmit(submit)}
              className="d-flex flex-column w-50"
            >
              <p style={{ textAlign: "center" }}>
                {t("profile.Modal2.SubTitle")}
              </p>
              <input
                type="password"
                {...register("oldPassword")}
                id="phone"
                className="form-control"
                placeholder={t("profile.Modal2.Input1")}
              />
              <p className="text-danger">{errors.oldPassword?.message}</p>
              <input
                type="password"
                id="name"
                {...register("newPassword")}
                className="form-control"
                placeholder={t("profile.Modal2.Input2")}
              />
              <p className="text-danger">{errors.newPassword?.message}</p>

              <button
                id="changepassword"
                className="btn btn-block login-btn mb-4"
                type="submit"
                style={{ backgroundColor: "#82ae46" }}
                disabled={isSubmitting}
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

export default ModalChangePass;
