import { RootState } from "../../../stores/store";

export const selectAllGroupProduct = (state: RootState) =>
  state?.groupProduct?.groupProducts;
