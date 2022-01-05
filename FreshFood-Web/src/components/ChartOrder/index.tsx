import HighchartsReact from "highcharts-react-official";
import Highcharts from "highcharts/highstock";
import React from "react";

const ChartStats = (props: {
  data: any;
  statsDate: any;
  headerText: string;
  yText: string;
  seriesText: string;
  className?: string | "";
}) => {
  const { data, statsDate, headerText, yText, seriesText, className } = props;
  const options = {
    chart: {
      type: "spline",
      styleMode: true,
    },
    title: {
      text: headerText,
    },

    yAxis: {
      title: {
        text: yText,
      },
    },

    xAxis: {
      // accessibility: {
      //   rangeDescription: "Range: 2010 to 2017",
      // },

      categories: statsDate,
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
        name: seriesText,
        data: data,
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

  return (
    <div className={className}>
      <HighchartsReact highcharts={Highcharts} options={options} />
    </div>
  );
};

export default ChartStats;
