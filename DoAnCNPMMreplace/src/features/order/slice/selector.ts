import { RootState } from "../../../stores/store";

export const selectDetailOrder = (state: RootState) => state?.order?.order;
export const selectAllOrder = (state: RootState) => state?.order?.listOrder;
