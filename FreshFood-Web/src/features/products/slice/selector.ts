import { RootState } from "../../../stores/store";

export const selectAllProduct = (state: RootState) => state?.product?.product;
export const selectDetailProduct = (state: RootState) =>
  state?.product?.productDetail;
