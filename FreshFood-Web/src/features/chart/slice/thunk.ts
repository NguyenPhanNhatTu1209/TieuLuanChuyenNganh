import { createAsyncThunk } from "@reduxjs/toolkit";
import {
  getGetStatisticOrderApi,
  payloadGetStatisticOrder,
} from "../../../apis/statistic/getStatisticOrder.api";

export const getAllChartAsync = createAsyncThunk(
  "statistic/getStatisticByOrder",
  async (payload: payloadGetStatisticOrder): Promise<any> => {
    const response = await getGetStatisticOrderApi(payload);
    return response.data;
  }
);
