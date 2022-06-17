import React from "react";
import { BoxChart } from "../../../components/BoxChart";
interface AnalyticsProps {}

const Analytics = (props: AnalyticsProps) => {
  return (
    <div className="container">
      <div className="d-inline-flex p-2 bd-highlight">
        <BoxChart select={1} />
        <BoxChart select={2} />
      </div>
    </div>
  );
};

export default Analytics;
