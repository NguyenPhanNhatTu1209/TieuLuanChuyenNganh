import { yupResolver } from "@hookform/resolvers/yup";
import React, { useState } from "react";
import { Form } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { getAllGroupProductApi } from "../../../apis/groupProduct/getAllGroupProduct.api";
import { createProductApi } from "../../../apis/product/createProduct.api";
import { ButtonSpinner } from "../../../components/ButtonSpinner";
import { createProductSchema } from "../../../validate/auth";
import { notifySuccess } from "../../../utils/notify";
import ModalUpdateGrP from "./component/ModalUpdateGrP";
import { useDispatch, useSelector } from "react-redux";
import { selectAllGroupProduct } from "../../../features/groupProduct/slice/selector";
import { getAllGroupProductAsync } from "../../../features/groupProduct/slice/thunk";

interface CreateProductPageProps {}

const CreateProductPage = (props: CreateProductPageProps) => {
  const [groupProduct, setGroupProduct] = useState([]);
  const [nameFile, setNameFile] = useState("");
  const [open, setOpen] = useState(false);
  const grProduct = useSelector(selectAllGroupProduct);
  const dispatch = useDispatch();
  const handdleOpen = () => {
    setOpen(true);
  };
  const handdleCancel = () => {
    setOpen(false);
  };
  const {
    register,
    handleSubmit,
    reset,
    formState: { isSubmitting, errors },
  } = useForm({ resolver: yupResolver(createProductSchema) });

  const submit = async (data: any, e: any) => {
    e.preventDefault();

    const result = await createProductApi(data);
    if (result.statusCode === 200) {
      notifySuccess("Create Product Successfully");
      reset();
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      const files = [...e.target.files];
      setNameFile(files.map((e: any) => e.name).join(","));
    }
  };

  React.useEffect(() => {
    dispatch(getAllGroupProductAsync());
  }, []);
  // console.log(groupProduct);
  return (
    <div className="createProduct container d-flex flex-column w-50">
      <form onSubmit={handleSubmit(submit)}>
        <p className="navbar-brand">Add Product</p>
        <input
          type="text"
          id="name"
          {...register("name")}
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
        <div className="d-flex">
          <Form.Select {...register("groupProduct")}>
            <option>Group Product</option>
            {grProduct.map((item: any, i: number) => (
              <option key={i}>{item.key}</option>
            ))}
          </Form.Select>
          {""}
          <button
            type="button"
            className="btn btn-primary"
            onClick={handdleOpen}
          >
            +
          </button>
        </div>
        <p className="text-danger">{errors.groupProduct?.message}</p>

        <input
          type="number"
          id="weight"
          onKeyDown={(e: any) => {
            e.preventDefault();
          }}
          min="1"
          {...register("weight")}
          className="form-control"
          placeholder="Weight"
        />
        <p className="text-danger">{errors.weight?.message}</p>
        <input
          type="number"
          id="quantity"
          onKeyDown={(e: any) => {
            e.preventDefault();
          }}
          min="1"
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
            required
            onChange={handleChange}
          />
          <label className="custom-file-label">
            {nameFile === "" ? "Image" : nameFile}
          </label>
          <div className="invalid-feedback">
            Example invalid custom file feedback
          </div>
        </div>

        <p></p>

        <button
          id="login"
          className="btn btn-block login-btn mb-4"
          type="submit"
          disabled={isSubmitting}
          style={{ backgroundColor: "#82ae46" }}
        >
          {!isSubmitting ? "Submit" : <ButtonSpinner />}
        </button>
      </form>
      <ModalUpdateGrP open={open} cancel={handdleCancel} />
    </div>
  );
};

export default CreateProductPage;
