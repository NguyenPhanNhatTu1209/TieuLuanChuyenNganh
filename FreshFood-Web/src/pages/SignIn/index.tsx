import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { IoLogoFacebook, IoLogoTwitter } from "react-icons/io";
import { useDispatch } from "react-redux";
import { Link, useHistory } from "react-router-dom";
import { ButtonSpinner } from "../../components/ButtonSpinner";
import {
  getCurrentUserAsync,
  userLoginAsync,
} from "../../features/auths/slice/thunk";
import { signInSchema } from "../../validate/auth";
import "./style.scss";

interface SignInProps {}

export const SignIn = (props: SignInProps) => {
  const { t, i18n } = useTranslation();
  const history = useHistory();
  const dispatch = useDispatch();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm({
    resolver: yupResolver(signInSchema),
  });
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    const result: any = await dispatch(userLoginAsync(data));
    if (result.payload.statusCode === 200) {
      if (result.payload.data.role === 0) {
        dispatch(getCurrentUserAsync());
        history.push("/");
        // window.open(`http://localhost:4000?token=${result.payload.data.token}`);
      } else if (result.payload.data.role === 1) {
        dispatch(getCurrentUserAsync());
        history.push("/analytics");
      } else if (result.payload.data.role === 2) {
        dispatch(getCurrentUserAsync());
        history.push("/order");
      }
    }
  };

  return (
    <div className="signInPage container">
      <div className="signInPage-form">
        <div className="signInPage-form-img">
          <img
            src="https://www.bootstrapdash.com/demo/login-template-free-2/assets/images/login.jpg"
            alt=""
          />
        </div>
        <form
          onSubmit={handleSubmit(submit)}
          className="signInPage-form-content"
        >
          <p>{t("signin.Title1")}</p>
          <input
            type="email"
            {...register("email")}
            id="email"
            className="form-control"
            placeholder={t("signin.Input1")}
          />
          <p className="text-danger">{errors.email?.message}</p>
          <input
            type="password"
            id="password"
            {...register("password")}
            className="form-control"
            placeholder={t("signin.Input2")}
          />
          <p className="text-danger">{errors.password?.message}</p>

          <button
            id="login"
            className="btn btn-block login-btn mb-4"
            type="submit"
            disabled={isSubmitting}
          >
            {!isSubmitting ? t("signin.Button1") : <ButtonSpinner />}
          </button>
          <Link to="/forgotpass">{t("signin.Button2")}</Link>
          <p></p>
          <p>
            {t("signin.Title2")}

            <Link to="/signup">{t("signin.Button3")}</Link>
          </p>
          <p>
            {t("signin.Title3")}{" "}
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
