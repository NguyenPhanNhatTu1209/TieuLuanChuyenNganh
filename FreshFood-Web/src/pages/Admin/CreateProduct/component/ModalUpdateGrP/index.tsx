import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useDispatch } from "react-redux";
import { createGroupProductApi } from "../../../../../apis/groupProduct/createGroupProduct.api";
import { getAllGroupProductApi } from "../../../../../apis/groupProduct/getAllGroupProduct.api";
import { ButtonSpinner } from "../../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../../components/Modal";
import { getAllGroupProductAsync } from "../../../../../features/groupProduct/slice/thunk";
import { notifySuccess } from "../../../../../utils/notify";

interface Props {
  cancel: Function;
  open: boolean;
}

const ModalUpdateGrP = (props: Props) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm({
    // resolver: yupResolver(addAddressSchema),
  });
  const dispatch = useDispatch();
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    const result = await createGroupProductApi(data);
    if (result.statusCode === 200) {
      notifySuccess("Add Successfully");
      reset();
      props.cancel();
      dispatch(getAllGroupProductAsync());
    }
  };

  return (
    <div>
      {props.open ? (
        <ModalLMS
          title="Add Group Product"
          withHeader={true}
          cancel={props.cancel}
        >
          <div className="d-flex justify-content-center">
            <form
              onSubmit={handleSubmit(submit)}
              className="d-flex flex-column w-50"
            >
              <input
                type="text"
                {...register("name")}
                id="name"
                className="form-control"
                placeholder="Name"
              />
              <p></p>
              <button
                id="changepassword"
                className="btn btn-block login-btn mb-4"
                type="submit"
                style={{ backgroundColor: "#82ae46" }}
                disabled={isSubmitting}
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

export default ModalUpdateGrP;
