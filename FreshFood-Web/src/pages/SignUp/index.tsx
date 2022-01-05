import React from "react";
import { useForm } from "react-hook-form";
import { IoLogoFacebook, IoLogoTwitter } from "react-icons/io";
import { Link, useHistory } from "react-router-dom";
import { registerAsync } from "../../apis/auths/register.api";
import { notifyError, notifySuccess } from "../../utils/notify";
import { signUpSchema } from "../../validate/auth";
import { yupResolver } from "@hookform/resolvers/yup";
import "./style.scss";
import { date } from "yup";
import { getCurrentUserAsync } from "../../features/auths/slice/thunk";
import { useDispatch } from "react-redux";
import { useTranslation } from "react-i18next";

interface SignInProps {}

export const SignUp = (props: SignInProps) => {
  const { t, i18n } = useTranslation();
  const history = useHistory(); //chuyen trang
  const dispatch = useDispatch();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm({
    resolver: yupResolver(signUpSchema),
  });
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    delete data.confirmPassword;
    console.log(data);
    const result = await registerAsync(data);

    console.log(result);
    if ([200, 201].includes(result.statusCode)) {
      //Luu token
      localStorage.setItem("token", result.data.token);
      dispatch(getCurrentUserAsync());
      //Thong bao
      notifySuccess("Đăng ký thành công");
      //Chuyen trang
      history.push("/");
    } else {
      notifyError("Đăng ký thất bại");
    }
  };

  return (
    <div className="signUpPage container">
      <div className="signUpPage-form">
        <div className="signUpPage-form-img">
          <img
            src="https://www.bootstrapdash.com/demo/login-template-free-2/assets/images/login.jpg"
            alt=""
          />
        </div>
        <form
          onSubmit={handleSubmit(submit)}
          className="signUpPage-form-content"
        >
          <p>{t("signup.Title1")}</p>
          <input
            type="email"
            {...register("email")}
            id="email"
            className="form-control"
            placeholder={t("signup.Input1")}
          />
          <p className="text-danger">{errors.email?.message}</p>
          <input
            type="text"
            {...register("name")}
            id="name"
            className="form-control"
            placeholder={t("signup.Input2")}
          />
          <p className="text-danger">{errors.name?.message}</p>
          <input
            type="text"
            id="phone"
            {...register("phone")}
            className="form-control"
            placeholder={t("signup.Input3")}
          />

          <p className="text-danger">{errors.phone?.message}</p>
          <input
            type="password"
            {...register("password")}
            id="password"
            className="form-control"
            placeholder={t("signup.Input4")}
          />
          <p className="text-danger">{errors.password?.message}</p>
          <input
            type="password"
            {...register("confirmPassword")}
            id="confirmPassword"
            className="form-control"
            placeholder={t("signup.Input5")}
          />
          <p className="text-danger">{errors.confirmPassword?.message}</p>
          <button
            id="register"
            className="btn btn-block login-btn mb-4"
            type="submit"
            disabled={isSubmitting}
          >
            {!isSubmitting ? (
              t("signup.Button1")
            ) : (
              <span className="spinner-border spinner-border-sm"></span>
            )}
          </button>
          <p>
            {t("signup.Title2")} <Link to="/signin">{t("signup.Button2")}</Link>
          </p>
          <p>
            {t("signup.Title3")}{" "}
            <a href="#">
              <IoLogoTwitter />
            </a>
            {""}{" "}
            <a href="#">
              <IoLogoFacebook />
            </a>
          </p>
        </form>
      </div>
    </div>
  );
};
