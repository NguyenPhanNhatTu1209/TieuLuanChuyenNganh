import { yupResolver } from "@hookform/resolvers/yup";
import React, { useState } from "react";
import { Form } from "react-bootstrap";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { useHistory, useParams } from "react-router";
import { getAllGroupProductApi } from "../../../apis/groupProduct/getAllGroupProduct.api";
import { updateProductApi } from "../../../apis/product/updateProduct.api";
import { ButtonSpinner } from "../../../components/ButtonSpinner";
import { getDetailProduct } from "../../../features/products/slice";
import { selectDetailProduct } from "../../../features/products/slice/selector";
import { notifyError, notifySuccess } from "../../../utils/notify";
import { createProductSchema } from "../../../validate/auth";
import "./style.scss";

interface CreateProductPageProps {}

const DetailProduct = (props: CreateProductPageProps) => {
  const { id } = useParams<any>();

  const [groupProduct, setGroupProduct] = useState([]);
  const [nameFile, setNameFile] = useState("");
  const productDetail = useSelector(selectDetailProduct);
  console.log(productDetail);
  const history = useHistory();
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

  const submit = async (data: any, e: any) => {
    e.preventDefault();
    data.id = id;
    console.log(data);
    const result = await updateProductApi(data);
    if (result.statusCode === 200) {
      notifySuccess("Cập nhật sản phẩm thành công");
      history.push("/updateproduct");
    } else {
      notifyError("Cập nhật thất bại");
    }
  };
  const dispatch = useDispatch();
  React.useEffect(() => {
    (async () => {
      const result = await getAllGroupProductApi();
      const { data } = result;
      setGroupProduct(data);
      dispatch(getDetailProduct(id));
    })();
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      const files = [...e.target.files];
      setNameFile(files.map((e: any) => e.name).join(","));
    }
  };

  const { t, i18n } = useTranslation();
  return (
    <div className="updateProduct container w-50">
      <form onSubmit={handleSubmit(submit)}>
        <p className="navbar-brand" style={{ color: "whitesmoke" }}>
          {t("admin.CreateProduct.HeaderTitle2")}
        </p>
        <div className="d-flex">
          <div className="updateProduct-left">
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
              onKeyDown={(e: any) => {
                e.preventDefault();
              }}
              min="1"
              id="weight"
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

            <p></p>

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
          <div className="updateProduct-right">
            <textarea
              id="detail"
              {...register("detail")}
              className="form-control"
              placeholder={t("admin.CreateProduct.Title5")}
            />
            <p className="text-danger">{errors.detail?.message}</p>
            <Form.Select {...register("groupProduct")}>
              <option>{t("admin.CreateProduct.Title6")}</option>
              {groupProduct.map((item: any, i: number) => (
                <option key={i}>{item.key}</option>
              ))}
            </Form.Select>
            <p className="text-danger">{errors.groupProduct?.message}</p>

            <div className="custom-file" style={{ overflow: "hidden" }}>
              <input
                multiple
                type="file"
                className="custom-file-input"
                id="validatedCustomFile"
                {...register("image")}
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
    </div>
  );
};

export default DetailProduct;
