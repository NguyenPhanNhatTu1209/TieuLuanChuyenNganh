import { RootState } from "../../../stores/store";

export const selectUserDetail = (state: RootState) => state?.user?.user;
