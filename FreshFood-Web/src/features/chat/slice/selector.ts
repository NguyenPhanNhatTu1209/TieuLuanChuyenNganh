import { RootState } from "../../../stores/store";

export const selectAllMessage = (state: RootState) => state?.chat?.message;
export const selectAllRoom = (state: RootState) => state?.chat?.room;
