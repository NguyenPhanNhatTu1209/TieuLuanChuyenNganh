import React from 'react'
import imgBanner from '../../../img/404.svg'
import { ErrLMS } from '../ERR'
interface NotFoundLMSProps {

}

export const NotFoundLMS = (props: NotFoundLMSProps) => {
  return (
  
      <ErrLMS imgBanner={imgBanner} title="OH no! Error 404" subTitle="Page not found" desc="Maybe Corona Virus has broken this page <br /> Comeback to the homepage " />
  )
}
