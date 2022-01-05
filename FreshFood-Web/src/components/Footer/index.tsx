import React from "react";
import { useTranslation } from "react-i18next";
import { BiCurrentLocation } from "react-icons/bi";
import {
  IoIosArrowUp,
  IoLogoFacebook,
  IoLogoInstagram,
  IoLogoTwitter,
  IoMdHeart,
  IoMdMail,
  IoMdPhonePortrait,
} from "react-icons/io";
import { Link } from "react-router-dom";

interface FooterPageProps {}

export const FooterPage = (props: FooterPageProps) => {
  const { t, i18n } = useTranslation();
  return (
    <footer className="ftco-footer ftco-section">
      <div className="container">
        <div className="row">
          <div className="mouse">
            <a href="#" className="mouse-icon">
              <div className="mouse-wheel">
                <IoIosArrowUp />
              </div>
            </a>
          </div>
        </div>
        <div className="row mb-5">
          <div className="col-md">
            <div className="ftco-footer-widget mb-4">
              <h2 className="ftco-heading-2">{t("footer.Title1")}</h2>
              <p>{t("footer.Caption1")}</p>
              <ul
                className="
									ftco-footer-social
									list-unstyled
									float-md-left float-lft
									mt-5
								"
              >
                <li className="ftco-animate">
                  <a
                    href="https://www.facebook.com/buitrunghieu2606/"
                    className="footer-social"
                  >
                    <IoLogoTwitter />
                    {/* <span className='icon-twitter'></span> */}
                  </a>
                </li>
                <li className="ftco-animate">
                  <a
                    href="https://www.facebook.com/buitrunghieu2606/"
                    className="footer-social"
                  >
                    <IoLogoFacebook />
                    {/* <span className='icon-facebook'></span> */}
                  </a>
                </li>
                <li className="ftco-animate">
                  <a
                    href="https://www.instagram.com/bt_hieu20/"
                    className="footer-social"
                  >
                    <IoLogoInstagram />
                    {/* <span className='icon-instagram'></span> */}
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div className="col-md">
            <div className="ftco-footer-widget mb-4 ml-md-5">
              <h2 className="ftco-heading-2">{t("footer.Title2")}</h2>
              <ul className="list-unstyled">
                <li>
                  <Link to="/Shop" className="py-2 d-block">
                    {t("footer.Caption2.Content1")}
                  </Link>
                </li>
                <li>
                  <Link to="/Contact" className="py-2 d-block">
                    {t("footer.Caption2.Content2")}
                  </Link>
                </li>
                <li>
                  <Link to="/" className="py-2 d-block">
                    {t("footer.Caption2.Content3")}
                  </Link>
                </li>
                <li>
                  <Link to="/Contact" className="py-2 d-block">
                    {t("footer.Caption2.Content4")}
                  </Link>
                </li>
              </ul>
            </div>
          </div>
          <div className="col-md-4">
            <div className="ftco-footer-widget mb-4">
              <h2 className="ftco-heading-2">{t("footer.Title3")}</h2>
              <div className="d-flex">
                <ul className="list-unstyled mr-l-5 pr-l-3 mr-4">
                  <li>
                    <Link to="/" className="py-2 d-block">
                      {t("footer.Caption3.Content1")}
                    </Link>
                  </li>
                  <li>
                    <Link to="/" className="py-2 d-block">
                      {t("footer.Caption3.Content2")}
                    </Link>
                  </li>
                  <li>
                    <Link to="/" className="py-2 d-block">
                      {t("footer.Caption3.Content3")}
                    </Link>
                  </li>
                  <li>
                    <Link to="/" className="py-2 d-block">
                      {t("footer.Caption3.Content4")}
                    </Link>
                  </li>
                </ul>
                <ul className="list-unstyled">
                  <li>
                    <Link to="/" className="py-2 d-block">
                      {t("footer.Caption3.Content5")}
                    </Link>
                  </li>
                  <li>
                    <Link to="/Contact" className="py-2 d-block">
                      {t("footer.Caption3.Content6")}
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <div className="col-md">
            <div className="ftco-footer-widget mb-4">
              <h2 className="ftco-heading-2">{t("footer.Title4")}</h2>
              <div className="block-23 mb-3">
                <ul>
                  <li>
                    <BiCurrentLocation />
                    {/* <span className='icon icon-map-marker'></span> */}
                    <span className="text">
                      28 Luu Chi Hieu street, Ba Ria city
                    </span>
                  </li>
                  <p></p>
                  <li>
                    <Link to="/">
                      <IoMdPhonePortrait />
                      {/* <span className='icon icon-phone'></span> */}

                      <span className="text">+0925 100 721</span>
                    </Link>
                  </li>
                  <li>
                    <Link to="/">
                      <IoMdMail />
                      {/* <span className='icon icon-envelope'></span> */}
                      <span className="text">TrumBR@gmail.com</span>
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-md-12 text-center">
            <p>
              Copyright &copy; 2021 All rights reserved | This template is made
              with <IoMdHeart />
              {/* <i
								className='icon-heart color-danger'
								aria-hidden='true'
							></i> */}
              by {""}
              <a
                href="https://www.facebook.com/buitrunghieu2606/"
                target="_blank"
              >
                TNH@hcmute.edu.vn
              </a>
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
};
