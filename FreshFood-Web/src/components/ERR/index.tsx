import React from "react";
import { FaFacebook } from "react-icons/fa";
import "./style.scss";
interface ErrLMSProps {
  imgBanner: string;
  subTitle: string;
  title: string;
  desc: string;
}

export const ErrLMS = (props: ErrLMSProps) => {
  return (
    <div className="wrapper container">
      <div className="banner">
        <div className="banner-image">
          <img src={props.imgBanner} alt="" />
        </div>
        <div className="banner-info">
          <h2 className="banner-subtitle">{props.subTitle}</h2>
          <h1 className="banner-title">{props.title}</h1>
          <div className="banner-desc">
            <h2>{props.desc}</h2>
          </div>
          <div className="contact">
            <p> Follow us on social media</p>
            <a href="https://www.facebook.com/buitrunghieu2606/">
              <FaFacebook />
            </a>
          </div>
        </div>
      </div>
    </div>
  );
};
