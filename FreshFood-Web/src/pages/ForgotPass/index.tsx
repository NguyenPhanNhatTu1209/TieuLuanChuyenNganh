import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { forgotPassAsync } from "../../apis/auths/forgotPass.api";
import { ButtonSpinner } from "../../components/ButtonSpinner";
import { notifyError, notifySuccess } from "../../utils/notify";
import { forgotPassSchema } from "../../validate/auth";
import "./style.scss";

export const ForgotPass = () => {
  const { t, i18n } = useTranslation();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm({
    resolver: yupResolver(forgotPassSchema),
  });
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    return new Promise((res) => {
      setTimeout(async () => {
        const result = await forgotPassAsync({ email: data.email });
        if (result.statusCode === 200) {
          notifySuccess("Kiểm tra e-mail của bạn");
        } else {
          notifyError("Email sai");
        }
        res(true);
      }, 2000);
    });
  };

  return (
    <div className="forgotPassPage container">
      <div className="forgotPassPage-form">
        <div className="forgotPassPage-form-img">
          <img
            src="https://www.bootstrapdash.com/demo/login-template-free-2/assets/images/login.jpg"
            alt=""
          />
        </div>
        <form
          className="forgotPassPage-form-content"
          onSubmit={handleSubmit(submit)}
        >
          <p>{t("forgotPass.Title")}</p>
          <input
            type="email"
            {...register("email")}
            id="email"
            className="form-control"
            placeholder={t("forgotPass.Input")}
          />

          <p className="text-danger">{errors.email?.message}</p>

          <button
            id="forgotpass"
            className="btn btn-block login-btn mb-4"
            disabled={isSubmitting}
          >
            {!isSubmitting ? t("forgotPass.Button") : <ButtonSpinner />}
          </button>
        </form>
      </div>
    </div>
  );
};
