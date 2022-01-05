import React, { useState } from "react";
import { getProductReccomendAsync } from "../../../../apis/product/getproductrecommend.api";
import CardProduct from "../../../../components/CardProduct";

const RelativeProduct = () => {
  const [listRecommendProduct, setListReccommendProduct] = useState<any>([]);

  React.useEffect(() => {
    (async () => {
      const result = await getProductReccomendAsync();
      const { data } = result;
      if (result.statusCode === 200) setListReccommendProduct(data);
      console.log(result);
    })();
  }, []);
  return (
    <div>
      <section className="ftco-section">
        <div className="container">
          <div className="row justify-content-center mb-3 pb-3">
            <div className="col-md-12 heading-section text-center ftco-animate">
              <span className="subheading">Products</span>
              <h2 className="mb-4">Related Products</h2>
            </div>
          </div>
        </div>
        <div className="container">
          <div className="row">
            {listRecommendProduct.map((e: any, i: number) => (
              <div className="col-md-6 col-lg-3 ftco-animate" key={i}>
                <CardProduct data={e} />
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
};

export default RelativeProduct;
