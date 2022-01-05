import { yupResolver } from "@hookform/resolvers/yup";
import React, { useState } from "react";
import { Form } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { useDispatch, useSelector } from "react-redux";
import { getAllGroupProductApi } from "../../../../../apis/groupProduct/getAllGroupProduct.api";
import { updateProductApi } from "../../../../../apis/product/updateProduct.api";
import { ButtonSpinner } from "../../../../../components/ButtonSpinner";
import { ModalLMS } from "../../../../../components/Modal";
import { selectDetailProduct } from "../../../../../features/products/slice/selector";
import { getAllProductAsync } from "../../../../../features/products/slice/thunk";
import { notifySuccess } from "../../../../../utils/notify";
import { createProductSchema } from "../../../../../validate/auth";

interface Props {
  cancel: Function;
  open: boolean;
}

const ModalUpdateProduct = (props: Props) => {
  const [groupProduct, setGroupProduct] = useState([]);

  React.useEffect(() => {
    (async () => {
      const result = await getAllGroupProductApi();
      const { data } = result;
      setGroupProduct(data);
    })();
  }, []);
  const productDetail = useSelector(selectDetailProduct);
  console.log(productDetail);
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm({
    resolver: yupResolver(createProductSchema),
    defaultValues: {
      name: productDetail?.name,
      detail: productDetail?.detail,
      groupProduct: productDetail?.groupProduct?.key,
      price: productDetail?.price,
      weight: productDetail?.weight,
      quantity: productDetail?.quantity,
      image: "",
    },
  });
  const dispatch = useDispatch();
  const submit = async (data: any, e: any) => {
    data.id = productDetail?.id;
    // data.quantity = +data.quantity;
    // data.weight = +data.weight;
    console.log(data);
    e.preventDefault();
    const result = await updateProductApi(data);
    if (result.statusCode === 200) {
      notifySuccess("Update product successfully");
      reset();
      props.cancel();
      dispatch(
        getAllProductAsync({
          skip: 1,
          limit: 15,
        })
      );
    }
  };
  return (
    <div>
      {props.open ? (
        <ModalLMS
          title="UPDATE PRODUCT"
          withHeader={true}
          cancel={props.cancel}
        >
          <div className="changeInfo">
            <form onSubmit={handleSubmit(submit)} className="changInfomation">
              <input
                type=""
                {...register("name")}
                id="name"
                className="form-control"
                placeholder="Name"
              />

              <p className="text-danger">{errors.name?.message}</p>
              <input
                type="text"
                id="detail"
                {...register("detail")}
                className="form-control"
                placeholder="Detail"
              />
              <p className="text-danger">{errors.detail?.message}</p>
              <input
                type="text"
                id="price"
                {...register("price")}
                className="form-control"
                placeholder="Price"
              />
              <p className="text-danger">{errors.price?.message}</p>
              <Form.Select {...register("groupProduct")}>
                <option>Group Product</option>
                {groupProduct.map((item: any, i: number) => (
                  <option key={i}>{item.key}</option>
                ))}
              </Form.Select>
              <p className="text-danger">{errors.groupProduct?.message}</p>

              <input
                type="number"
                onKeyDown={(e: any) => {
                  e.preventDefault();
                }}
                min="1"
                id="weight"
                {...register("weight")}
                className="form-control"
                placeholder="Weight"
              />
              <p className="text-danger">{errors.weight?.message}</p>
              <input
                type="number"
                onKeyDown={(e: any) => {
                  e.preventDefault();
                }}
                min="1"
                id="quantity"
                {...register("quantity")}
                className="form-control"
                placeholder="Quantity"
              />
              <p className="text-danger">{errors.quantity?.message}</p>

              <div className="custom-file">
                <input
                  multiple
                  type="file"
                  className="custom-file-input"
                  id="validatedCustomFile"
                  {...register("image")}
                />
                <label className="custom-file-label">Image</label>
                <div className="invalid-feedback">
                  Example invalid custom file feedback
                </div>
              </div>
              <p></p>
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

export default ModalUpdateProduct;
