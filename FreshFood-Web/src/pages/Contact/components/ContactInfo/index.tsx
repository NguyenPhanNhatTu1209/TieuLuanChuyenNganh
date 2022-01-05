import React from "react";
import avatar from "../../../../images/MN.jpg";
import backgournd from "../../../../images/bg_1.jpg";
import { useTranslation } from "react-i18next";
interface Props {}

const ContactInfo = (props: Props) => {
  const { t, i18n } = useTranslation();
  return (
    <section className="ftco-section contact-section bg-light">
      <div className="container">
        <div className="row d-flex mb-5 contact-info">
          <div className="w-100"></div>
          <div className="col-md-3 d-flex">
            <div className="info bg-white p-4">
              <p>
                <span>{t("contact.Banner2.Title1")}:</span> 28 Luu Chi Hieu
                street, Ba Ria city
              </p>
            </div>
          </div>
          <div className="col-md-3 d-flex">
            <div className="info bg-white p-4">
              <p>
                <span>{t("contact.Banner2.Title2")}:</span>{" "}
                <a href="tel://1234567920">+ 0925 100 721</a>
              </p>
            </div>
          </div>
          <div className="col-md-3 d-flex">
            <div className="info bg-white p-4">
              <p>
                <span>Email:</span>{" "}
                <a href="mailto:info@yoursite.com">TrumBR@gmail.com</a>
              </p>
            </div>
          </div>
          <div className="col-md-3 d-flex">
            <div className="info bg-white p-4">
              <p>
                <span>Website:</span> <a href="#">FreshFoodVn.com</a>
              </p>
            </div>
          </div>
        </div>
        <div className="row block-9">
          <div className="col-md-6 order-md-last d-flex">
            <form action="#" className="bg-white p-5 contact-form">
              <div className="form-group">
                <input
                  type="text"
                  className="form-control"
                  placeholder={t("contact.Info.Input1")}
                />
              </div>
              <div className="form-group">
                <input
                  type="text"
                  className="form-control"
                  placeholder={t("contact.Info.Input2")}
                />
              </div>
              <div className="form-group">
                <input
                  type="text"
                  className="form-control"
                  placeholder={t("contact.Info.Input3")}
                />
              </div>
              <div className="form-group">
                {/* <textarea name="" id="" cols="30" rows="7" className="form-control" placeholder="Message"></textarea> */}
              </div>
              <div className="form-group">
                <button type="submit" className="btn btn-primary py-3 px-5">
                  {t("contact.Info.Button")}
                </button>
              </div>
            </form>
          </div>

          <div className="col-md-6 d-flex">
            <img src={backgournd} alt="" />
          </div>
        </div>
      </div>
    </section>
  );
};

export default ContactInfo;
