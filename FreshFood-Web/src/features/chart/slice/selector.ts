import { RootState } from "../../../stores/store";

export const selectAllChart = (state: RootState) => state?.statistic?.chart;
