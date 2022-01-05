import React from "react";
import imgBanner from "../../images/404.svg";
import { ErrLMS } from "../ERR";
interface ForbiddenLMSProps {}

export const ForbiddenLMS = (props: ForbiddenLMSProps) => {
  return (
    <ErrLMS
      imgBanner={imgBanner}
      title="OH no! Error 404"
      subTitle="Page not found"
      desc="Maybe Corona Virus has broken this page <br /> Comeback to the homepage "
    />
  );
};
