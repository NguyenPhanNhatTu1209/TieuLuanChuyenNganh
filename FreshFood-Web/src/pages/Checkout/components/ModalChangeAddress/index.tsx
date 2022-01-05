import { yupResolver } from "@hookform/resolvers/yup";
import React from "react";
import { useForm } from "react-hook-form";
import { useDispatch } from "react-redux";
import { createAddressAsync } from "../../../../apis/address/createAddress.api";
import { ButtonSpinner } from "../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../components/Modal";
import { getAllAddressAsync } from "../../../../features/address/slice/thunk";
import { notifySuccess } from "../../../../utils/notify";
import { addAddressSchema } from "../../../../validate/auth";

interface Props {
  cancel: Function;
  open: boolean;
}

const ModalChangeAddress = (props: Props) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm({
    resolver: yupResolver(addAddressSchema),
  });
  const dispatch = useDispatch();
  const submit = async (data: any, e: any) => {
    e.preventDefault();
    data.isMain = true;
    const result = await createAddressAsync(data);
    if (result.statusCode === 200) {
      notifySuccess("Thêm địa chỉ thành công");
      reset();
      props.cancel();
      dispatch(getAllAddressAsync());
    }
  };

  return (
    <div>
      {props.open ? (
        <ModalLMS title="Add Address" withHeader={true} cancel={props.cancel}>
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
              <p className="text-danger">{errors.name?.message}</p>
              <input
                type="text"
                id="phone"
                {...register("phone")}
                className="form-control"
                placeholder="Phone"
              />
              <p className="text-danger">{errors.phone?.message}</p>

              <input
                type="text"
                id="province"
                {...register("province")}
                className="form-control"
                placeholder="Province"
              />
              <p className="text-danger">{errors.province?.message}</p>

              <input
                type="text"
                id="district"
                {...register("district")}
                className="form-control"
                placeholder="District"
              />
              <p className="text-danger">{errors.district?.message}</p>

              <input
                type="text"
                id="address"
                {...register("address")}
                className="form-control"
                placeholder="Address"
              />
              <p className="text-danger">{errors.address?.message}</p>

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

export default ModalChangeAddress;
