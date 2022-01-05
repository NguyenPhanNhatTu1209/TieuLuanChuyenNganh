import { RootState } from "../../../stores/store";

export const selectUserDetail = (state: RootState) => state?.user?.user;
export const selectAllUser = (state: RootState) => state?.user?.allUser;
