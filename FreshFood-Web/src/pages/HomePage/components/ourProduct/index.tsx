import React, { useState } from "react";
import { getAllProductApi } from "../../../../apis/product/getallproduct.api";
import CardProduct from "../../../../components/CardProduct";

interface Props {}

const OurProduct = (props: Props) => {
  const [list, setList] = useState<any>([]);

  React.useEffect(() => {
    const getData = async () => {
      const result = await getAllProductApi({ limit: 20, skip: 1 });
      console.log(result);
      const { data } = result;
      setList(data);
    };
    getData();
  }, []);
  return (
    <section className="ftco-section">
      <div className="container">
        <div className="row justify-content-center mb-3 pb-3">
          <div
            className="
							col-md-12
							heading-section
							text-center
							ftco-animate
						"
          >
            <span className="subheading">Featured Products</span>
            <h2 className="mb-4">Our Products</h2>
            <p>Fresh Food from around the world</p>
          </div>
        </div>
      </div>
      <div className="container">
        <div className="row">
          {list.map((e: any, i: number) => (
            <div className="col-md-6 col-lg-3 ftco-animate" key={i}>
              <CardProduct data={e} />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default OurProduct;
