import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useHistory } from "react-router-dom";
import { ButtonSpinner } from "../../components/ButtonSpinner";
import { signInSchema } from "../../validate/auth";
import "./style.scss";

interface ResetPassProps {}

export const ResetPass = (props: ResetPassProps) => {
  const history = useHistory();
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm({
    resolver: yupResolver(signInSchema),
  });
  const submit = async (data: any, e: any) => {
    e.preventDefault();
  };

  return (
    <div className="resetPassPage container">
      <div className="resetPassPage-form">
        <div className="resetPassPage-form-img">
          <img
            src="https://www.bootstrapdash.com/demo/login-template-free-2/assets/images/login.jpg"
            alt=""
          />
        </div>
        <form
          onSubmit={handleSubmit(submit)}
          className="resetPassPage-form-content"
        >
          <p>Reset Password</p>
          <input
            type="email"
            {...register("email")}
            id="email"
            className="form-control"
            placeholder="Email address"
          />
          <p className="text-danger">{errors.email?.message}</p>
          <input
            type="password"
            id="password"
            {...register("password")}
            className="form-control"
            placeholder="Password"
          />
          <p className="text-danger">{errors.password?.message}</p>

          <button
            id="login"
            className="btn btn-block login-btn mb-4"
            type="submit"
            disabled={isSubmitting}
          >
            {!isSubmitting ? "Submit" : <ButtonSpinner />}
          </button>
        </form>
      </div>
    </div>
  );
};
