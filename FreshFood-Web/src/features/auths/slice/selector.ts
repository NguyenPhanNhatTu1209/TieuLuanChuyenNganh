import { RootState } from "../../../stores/store";

export const selectCurrentUser = (state: RootState) => state?.auth?.user;
