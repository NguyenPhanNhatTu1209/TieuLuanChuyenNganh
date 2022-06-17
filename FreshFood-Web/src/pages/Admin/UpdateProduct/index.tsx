import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getAllGroupProductApi } from "../../../apis/groupProduct/getAllGroupProduct.api";
import { getAllProductApi } from "../../../apis/product/getallproduct.api";
import HeroCommon from "../../../components/HeroCommon";
import Pagination from "../../../components/Pagination";
import { selectAllProduct } from "../../../features/products/slice/selector";
import { getAllProductAsync } from "../../../features/products/slice/thunk";
import ShopProduct from "./components/ShopProduct";

const UpdateProduct = () => {
  // const [groupProduct, setGroupProduct] = useState([]);
  const [query, setQuery] = useState({ limit: 8, skip: 1, groupProduct: "" });
  const product = useSelector(selectAllProduct);
  console.log(product);
  React.useEffect(() => {
    getData();
  }, []);

  const dispatch = useDispatch();
  const getData = async () => {
    // const result = await getAllProductApi(query);
    dispatch(getAllProductAsync(query));
  };

  const handleChangePage = async (page: number) => {
    // const result = await getAllProductApi({ ...query, skip: page });
    dispatch(getAllProductAsync({ ...query, skip: page }));
    // setQuery({ ...query, skip: page });
  };

  // React.useEffect(() => {
  //   (async () => {
  //     const result = await getAllGroupProductApi();
  //     const { data } = result;
  //     setGroupProduct(data);
  //   })();
  // }, []);

  return (
    <main>
      <HeroCommon />
      <section className="ftco-section">
        <div className="container">
          <ShopProduct data={product?.data} />
          <Pagination
            page={product?.numberPage}
            handleChangePage={handleChangePage}
          />
        </div>
      </section>
    </main>
  );
};

export default UpdateProduct;
