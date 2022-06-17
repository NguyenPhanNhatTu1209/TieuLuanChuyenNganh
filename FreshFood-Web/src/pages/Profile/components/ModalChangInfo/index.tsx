import { yupResolver } from "@hookform/resolvers/yup";
import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router";
import { updateInfomatinApi } from "../../../../apis/auths/updateinfomation.api";
import { ButtonSpinner } from "../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../components/Modal";
import { notifySuccess } from "../../../../utils/notify";
import { updateInfoSchema } from "../../../../validate/auth";
import { getCurrentUserAsync } from "../../../../features/auths/slice/thunk";
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
      notifySuccess("Change info successfully");
      reset();
      props.cancel();
      dispatch(getCurrentUserAsync());
    }
  };
  return (
    <div>
      {props.open ? (
        <ModalLMS title="Change InFo" withHeader={true} cancel={props.cancel}>
          <div className="changeInfo">
            <form onSubmit={handleSubmit(submit)} className="changInfomation">
              <p>INFOMATION</p>
              <input
                type=""
                {...register("phone")}
                id="phone"
                className="form-control"
                placeholder="Phone"
              />
              <p className="text-danger">{errors.phone?.message}</p>
              <input
                type="text"
                id="name"
                {...register("name")}
                className="form-control"
                placeholder="Name"
              />
              <p className="text-danger">{errors.name?.message}</p>

              <button
                id="changeinfo"
                className="btn btn-block login-btn mb-4"
                type="submit"
                style={{ backgroundColor: "#82ae46" }}
              >
                {isSubmitting ? <ButtonSpinner /> : "Submit"}
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
