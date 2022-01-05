import React from "react";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";
import bg1 from "../../../../images/bg_1.jpg";
interface Props {}

const HeroWrap = (props: Props) => {
  const { t, i18n } = useTranslation();
  return (
    <div
      className="hero-wrap hero-bread"
      style={{ backgroundImage: `url(${bg1})` }}
    >
      <div className="container">
        <div className="row no-gutters slider-text align-items-center justify-content-center">
          <div className="col-md-9 ftco-animate text-center">
            <p className="breadcrumbs">
              <span className="mr-2">
                <Link to="#">{t("cart.Banner1.Title1")}</Link>
              </span>
            </p>
            <h1 className="mb-0 bread">{t("cart.Banner1.Title2")}</h1>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HeroWrap;
