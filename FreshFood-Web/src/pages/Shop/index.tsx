import React, { useState } from "react";
import { getAllGroupProductApi } from "../../apis/groupProduct/getAllGroupProduct.api";
import { getAllProductApi } from "../../apis/product/getallproduct.api";
import HeroCommon from "../../components/HeroCommon";
import Pagination from "../../components/Pagination";
import ShopFilter from "./components/ShopFilter";
import ShopProduct from "./components/ShopProduct";

const ShopPage = () => {
  const [list, setList] = useState<any>([]);
  const [page, setPage] = useState<any>(1);
  const [groupProduct, setGroupProduct] = useState([]);
  const [query, setQuery] = useState({ limit: 8, skip: 1, groupProduct: "" });
  React.useEffect(() => {
    getData();
  }, []);
  const getData = async () => {
    const result = await getAllProductApi(query);
    console.log(result);
    const { data, numberPage } = result;
    setPage(numberPage);
    setList(data);
  };

  const handleChangePage = async (page: number) => {
    const result = await getAllProductApi({ ...query, skip: page });
    // setQuery({ ...query, skip: page });
    const { data, numberPage } = result;
    setPage(numberPage);
    setList(data);
  };

  const handleChangeCategory = async (key: string) => {
    const result = await getAllProductApi({
      ...query,
      groupProduct: key,
      skip: 1,
    });
    console.log("123", result);
    setQuery({
      ...query,
      groupProduct: key,
    });
    console.log(query);
    const { data, numberPage } = result;
    setPage(numberPage);
    setList(data);
    console.log(result);
  };

  React.useEffect(() => {
    (async () => {
      const result = await getAllGroupProductApi();
      const { data } = result;
      setGroupProduct(data);
    })();
  }, []);

  return (
    <main>
      <HeroCommon />
      <section className="ftco-section">
        <div className="container">
          <ShopFilter
            groupProducts={groupProduct}
            changeCategory={handleChangeCategory}
          />
          <ShopProduct data={list} />
          <Pagination page={page} handleChangePage={handleChangePage} />
        </div>
      </section>
    </main>
  );
};

export default ShopPage;
