import { yupResolver } from "@hookform/resolvers/yup";
import React, { useState } from "react";
import { Form } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { createProductApi } from "../../../apis/product/createProduct.api";
import { ButtonSpinner } from "../../../components/ButtonSpinner";
import { selectAllGroupProduct } from "../../../features/groupProduct/slice/selector";
import { getAllGroupProductAsync } from "../../../features/groupProduct/slice/thunk";
import { notifySuccess } from "../../../utils/notify";
import { createProductSchema } from "../../../validate/auth";
import ModalUpdateGrP from "./component/ModalUpdateGrP";
import "./style.scss";

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
      notifySuccess("Tạo sản phẩm thành công");
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

  const { t, i18n } = useTranslation();
  return (
    <div className="createProduct container w-50">
      <form onSubmit={handleSubmit(submit)}>
        <p className="navbar-brand" style={{ color: "whitesmoke" }}>
          {t("admin.CreateProduct.HeaderTitle")}
        </p>
        <div className="d-flex">
          <div className="createProduct-left">
            <input
              type="text"
              id="name"
              {...register("name")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title1")}
            />
            <p className="text-danger">{errors.name?.message}</p>

            <input
              type="text"
              id="price"
              {...register("price")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title2")}
            />
            <p className="text-danger">{errors.price?.message}</p>

            <input
              type="number"
              id="weight"
              onKeyDown={(e: any) => {
                e.preventDefault();
              }}
              min="1"
              {...register("weight")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title3")}
            />
            <p className="text-danger">{errors.weight?.message}</p>
            <input
              onKeyDown={(e: any) => {
                e.preventDefault();
              }}
              min="1"
              type="number"
              id="quantity"
              {...register("quantity")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title4")}
            />
            <p className="text-danger">{errors.quantity?.message}</p>

            <button
              id="login"
              className="btn btn-block login-btn mb-4"
              type="submit"
              disabled={isSubmitting}
              style={{ backgroundColor: "#f5a623" }}
            >
              {!isSubmitting ? (
                t("admin.CreateProduct.Button")
              ) : (
                <ButtonSpinner />
              )}
            </button>
          </div>

          <div className="createProduct-right">
            <textarea
              id="detail"
              {...register("detail")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title5")}
            />
            <p className="text-danger">{errors.detail?.message}</p>
            <div className="d-flex justifycontent-space-between">
              <Form.Select {...register("groupProduct")}>
                <option>{t("admin.CreateProduct.Title6")}</option>
                {grProduct.map((item: any, i: number) => (
                  <option key={i}>{item.key}</option>
                ))}
              </Form.Select>

              <button
                style={{ backgroundColor: "#f5a623", marginLeft: "3px" }}
                type="button"
                className="btn btn-primary"
                onClick={handdleOpen}
              >
                +
              </button>
            </div>
            <p className="text-danger">{errors.groupProduct?.message}</p>
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
          </div>
        </div>
      </form>
      <ModalUpdateGrP open={open} cancel={handdleCancel} />
    </div>
  );
};

export default CreateProductPage;
