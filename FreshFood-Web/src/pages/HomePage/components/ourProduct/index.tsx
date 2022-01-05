import { t } from "i18next";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { getAllProductApi } from "../../../../apis/product/getallproduct.api";
import { getProductReccomendAsync } from "../../../../apis/product/getproductrecommend.api";
import CardProduct from "../../../../components/CardProduct";

interface Props {}

const OurProduct = (props: Props) => {
  const { t, i18n } = useTranslation();
  const [list, setList] = useState<any>([]);

  React.useEffect(() => {
    const getData = async () => {
      const result = await getProductReccomendAsync();
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
            <span className="subheading">{t("homePage.Banner3.Title1")}</span>
            <h2 className="mb-4">{t("homePage.Banner3.Title2")}</h2>
            <p>{t("homePage.Banner3.Title3")}</p>
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
