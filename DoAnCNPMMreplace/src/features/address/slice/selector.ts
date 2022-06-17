import { RootState } from "../../../stores/store";

export const selectAllAddress = (state: RootState) => state?.address?.addresses;
