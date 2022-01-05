import React from "react";
import Chart from "react-google-charts";
import { useTranslation } from "react-i18next";

export const ChartPie = (props: { product: any; sold: any }) => {
  const { t, i18n } = useTranslation();
  return (
    <>
      <Chart
        width={"800px"}
        height={"400px"}
        chartType="PieChart"
        loader={<div>Loading Chart</div>}
        data={[
          ["Products", "Popularity"],
          [props.product[0], props.sold[0]],
          [props.product[1], props.sold[1]],
          [props.product[2], props.sold[2]],
          [props.product[3], props.sold[3]],
          [props.product[4], props.sold[4]],
        ]}
        options={{
          title: t("admin.Analytics.ChartTitle3"),
        }}
        rootProps={{ "data-testid": "1" }}
      />
    </>
  );
};
