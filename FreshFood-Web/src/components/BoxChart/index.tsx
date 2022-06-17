import React from "react";
import Chart from "../Chart";

export const BoxChart = (props: { select: number }) => {
  return (
    <div className="bg-white border-transparent rounded-lg shadow-xl">
      <div className="p-5">
        <Chart type="spline" select={props.select} />
      </div>
    </div>
  );
};
