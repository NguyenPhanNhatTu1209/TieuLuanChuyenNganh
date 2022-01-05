import {
  configureStore,
  StateFromReducersMapObject,
  DeepPartial,
  Action,
} from "@reduxjs/toolkit";
import thunk, { ThunkAction } from "redux-thunk";
import authReducer from "../features/auths/slice";
import addressReducer from "../features/address/slice";
import orderReducer from "../features/order/slice";
import productReducer from "../features/products/slice";
import userReducer from "../features/user/slice";
import groupProductReducer from "../features/groupProduct/slice";
import statisticReducer from "../features/chart/slice";
import chatReducer from "../features/chat/slice";

const reducer = {
  auth: authReducer,
  address: addressReducer,
  order: orderReducer,
  product: productReducer,
  user: userReducer,
  groupProduct: groupProductReducer,
  statistic: statisticReducer,
  chat: chatReducer,
};

export type IRootState = StateFromReducersMapObject<typeof reducer>;
type Store = ReturnType<typeof initConfigStore>;

function initConfigStore(preloadedState?: DeepPartial<IRootState>) {
  return configureStore({
    reducer,
    preloadedState: preloadedState,
    middleware: [thunk],
  });
}

export const store = initConfigStore();

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
export default store;
