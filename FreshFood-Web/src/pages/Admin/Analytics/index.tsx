import dayjs from "dayjs";
import _ from "lodash";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { getProductStatisticApi } from "../../../apis/statistic/getProducStatistic.api";
import { payloadGetStatisticOrder } from "../../../apis/statistic/getStatisticOrder.api";
import ChartStats from "../../../components/ChartOrder";
import { ChartPie } from "../../../components/PieChart";
import { selectAllChart } from "../../../features/chart/slice/selector";
import { getAllChartAsync } from "../../../features/chart/slice/thunk";
import { formatDate } from "../../../utils/datFormater";

interface AnalyticsProps {}

const Analytics = (props: AnalyticsProps) => {
  const [productStatistc, setProductStatistic] = useState<any>([]);
  const dispatch = useDispatch();
  const timeEnd = formatDate(dayjs().toDate());
  const timeStart = formatDate(dayjs().subtract(6, "d").toDate());
  const Arr = (day: string) =>
    [...Array(7)]
      .map((item: any, i: number) =>
        formatDate(dayjs(day).subtract(i, "d").toDate())
      )
      .reverse();
  const [statsDay, setStatsDay] = useState<any>(
    Arr(formatDate(dayjs().toDate()))
  );

  const payload: payloadGetStatisticOrder = {
    timeStart: timeStart,
    timeEnd: timeEnd,
  };

  React.useEffect(() => {
    dispatch(getAllChartAsync(payload));
    (async () => {
      const result = await getProductStatisticApi();

      const { data } = result;
      setProductStatistic(data);
    })();
  }, []);

  const name = _.map(productStatistc, "name");
  const sold = _.map(productStatistc, "sold");

  const statistic = useSelector(selectAllChart);

  const totalOrder = _.map(statistic, "totalOrder");
  const totalMoney = _.map(statistic, "totalMoney");

  const handleOnchangeDay = (e: any) => {
    const result = e.target.value;
    const newStartTime = formatDate(dayjs(result).subtract(6, "d").toDate());
    dispatch(getAllChartAsync({ timeStart: newStartTime, timeEnd: result }));
    setStatsDay(Arr(result));
  };
  const { t, i18n } = useTranslation();
  return (
    <div className="container">
      <div>
        <span> </span>
        <span>{t("admin.Analytics.TimeEnd")} </span>
        <input
          type="date"
          id="end"
          name="trip-end"
          defaultValue={timeEnd}
          max={timeEnd}
          min="2021-11-17"
          onChange={handleOnchangeDay}
        />
      </div>
      <div className="d-flex justify-content-between">
        <ChartStats
          data={totalOrder}
          statsDate={statsDay}
          headerText={t("admin.Analytics.ChartTitle1")}
          yText={t("admin.Analytics.SubTitle1")}
          seriesText={t("admin.Analytics.Caption1")}
          className="mb-5"
        />

        <ChartStats
          data={totalMoney}
          statsDate={statsDay}
          headerText={t("admin.Analytics.ChartTitle2")}
          yText={t("admin.Analytics.SubTitle2")}
          seriesText={t("admin.Analytics.Caption2")}
        />
      </div>
      <div className="d-flex justify-content-center">
        <ChartPie product={name} sold={sold} />
      </div>
    </div>
  );
};

export default Analytics;
