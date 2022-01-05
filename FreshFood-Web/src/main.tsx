import React, { Suspense } from "react";
import ReactDOM from "react-dom";
import "./index.css";
import { Provider } from "react-redux";
import App from "./App";
import store from "./stores/store";
import "./i18next";
import { LoadingLMS } from "./components/Loading";

ReactDOM.render(
  // <React.StrictMode>
  <Provider store={store}>
    <Suspense fallback={<LoadingLMS loading={true} />}>
      <App />
    </Suspense>
  </Provider>,
  // </React.StrictMode>,
  document.getElementById("root")
);
