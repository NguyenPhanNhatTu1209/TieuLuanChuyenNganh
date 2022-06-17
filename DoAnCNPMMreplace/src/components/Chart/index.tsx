import React, { useState } from "react";
import { render } from "react-dom";
import Highcharts from "highcharts/highstock";
import HighchartsReact from "highcharts-react-official";
import {
  getGetStatisticOrderApi,
  payloadGetStatisticOrder,
} from "../../apis/statistic/getStatisticOrder.api";
import _ from "lodash";

const Chart = (props: { type: string; select: number }) => {
  const [statistic, setStatistic] = useState<any>([]);
  const dateTimeEnd = Date.now();
  const dateTimeStart = new Date(dateTimeEnd - 7 * 24 * 3600);
  const payload: payloadGetStatisticOrder = {
    timeStart: "2021-12-03",
    timeEnd: "2021-12-09",
  };
  React.useEffect(() => {
    (async () => {
      const result = await getGetStatisticOrderApi(payload);
      const { data } = result;
      setStatistic(data);
    })();
  }, []);
  // console.log(statistic);
  const totalOrder = _.map(statistic, "totalOrder");
  const totalMoney = _.map(statistic, "totalMoney");

  const options1 = {
    chart: {
      type: "spline",
    },
    title: {
      text: "Total Order 7 Days",
    },

    yAxis: {
      title: {
        text: "Total Order",
      },
    },

    xAxis: {
      // accessibility: {
      //   rangeDescription: "Range: 2010 to 2017",
      // },

      categories: [
        "2021-12-03",
        "2021-12-04",
        "2021-12-05",
        "2021-12-06",
        "2021-12-07",
        "2021-12-08",
        "2021-12-09",
      ],
    },

    legend: {
      layout: "vertical",
      align: "right",
      verticalAlign: "middle",
    },

    // plotOptions: {
    //   series: {
    //     label: {
    //       connectorAllowed: false,
    //     },
    //     pointStart: 2021,
    //   },
    // },

    series: [
      {
        name: "Order",
        data: [
          totalOrder[0],
          totalOrder[1],
          totalOrder[2],
          totalOrder[3],
          totalOrder[4],
          totalOrder[5],
          totalOrder[6],
          totalOrder[7],
        ],
      },
    ],

    responsive: {
      rules: [
        {
          condition: {
            maxWidth: 500,
          },
          chartOptions: {
            legend: {
              layout: "horizontal",
              align: "center",
              verticalAlign: "bottom",
            },
          },
        },
      ],
    },
  };

  const options2 = {
    chart: {
      type: "spline",
    },
    title: {
      text: "Total Money 7 Days",
    },

    yAxis: {
      title: {
        text: "Money",
      },
    },

    xAxis: {
      // accessibility: {
      //   rangeDescription: "Range: 2010 to 2017",
      // },

      categories: [
        "2021-12-03",
        "2021-12-04",
        "2021-12-05",
        "2021-12-06",
        "2021-12-07",
        "2021-12-08",
        "2021-12-09",
      ],
    },

    legend: {
      layout: "vertical",
      align: "right",
      verticalAlign: "middle",
    },

    // plotOptions: {
    //   series: {
    //     label: {
    //       connectorAllowed: false,
    //     },
    //     pointStart: 2010,
    //   },
    // },

    series: [
      {
        name: "Money",
        data: [
          totalMoney[0],
          totalMoney[1],
          totalMoney[2],
          totalMoney[3],
          totalMoney[4],
          totalMoney[5],
          totalMoney[6],
          totalMoney[7],
        ],
      },
    ],

    responsive: {
      rules: [
        {
          condition: {
            maxWidth: 500,
          },
          chartOptions: {
            legend: {
              layout: "horizontal",
              align: "center",
              verticalAlign: "bottom",
            },
          },
        },
      ],
    },
  };
  let choose;
  if (props.select === 1) {
    choose = options1;
  } else {
    choose = options2;
  }
  return (
    <div>
      <HighchartsReact highcharts={Highcharts} options={choose} />
    </div>
  );
};

export default Chart;
