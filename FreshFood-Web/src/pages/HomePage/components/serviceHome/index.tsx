import React from "react";
import Slider from "react-slick";
import img1 from "../../../../images/shipped.png";
import img2 from "../../../../images/fresh.png";
import img3 from "../../../../images/quality.png";
import img4 from "../../../../images/contact.png";
import { useTranslation } from "react-i18next";

const ServiceHome = () => {
  const { t, i18n } = useTranslation();
  const heroBanner: Array<{ title: string; caption: string; img: string }> = [
    {
      title: t("homePage.Banner2.Title1"),
      caption: t("homePage.Banner2.Caption1"),
      img: img1,
    },
    {
      title: t("homePage.Banner2.Title2"),
      caption: t("homePage.Banner2.Caption2"),
      img: img2,
    },
    {
      title: t("homePage.Banner2.Title3"),
      caption: t("homePage.Banner2.Caption3"),
      img: img3,
    },
    {
      title: t("homePage.Banner2.Title4"),
      caption: t("homePage.Banner2.Caption4"),
      img: img4,
    },
  ];
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
  };
  return (
    <section className="ftco-section">
      <div className="container">
        <div className="row no-gutters ftco-services">
          {heroBanner.map((e, i) => {
            return (
              <div
                className="
                    col-md-3
                    text-center
                    d-flex
                    align-self-stretch
                "
                key={i}
              >
                <div className="media block-6 services mb-md-0 mb-4">
                  <div
                    className="
                            icon
                            bg-color-1
                            active
                            d-flex
                            justify-content-center
                            align-items-center
                            mb-2
                        "
                  >
                    <div className="serviceHome-icon">
                      <img src={e.img}></img>
                    </div>
                  </div>
                  <div className="media-body">
                    <h3 className="heading">{e.title}</h3>
                    <span>{e.caption}</span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
};

export default ServiceHome;
