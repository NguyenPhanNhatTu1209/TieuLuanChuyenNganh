import React from "react";
import { useTranslation } from "react-i18next";
const Subcribe = () => {
  const { t, i18n } = useTranslation();
  return (
    <div>
      <section className="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
        <div className="container py-4">
          <div className="row d-flex justify-content-center py-5">
            <div className="col-md-6">
              <h2 className="mb-0">{t("subscribe.Title")}</h2>
              <span>{t("subscribe.Caption")}</span>
            </div>
            <div className="col-md-6 d-flex align-items-center">
              <form action="#" className="subscribe-form">
                <div className="form-group d-flex">
                  <input
                    type="text"
                    className="form-control"
                    placeholder={t("subscribe.Input")}
                  />
                  <button type="submit" className="submit px-3">
                    {t("subscribe.Button")}
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Subcribe;
