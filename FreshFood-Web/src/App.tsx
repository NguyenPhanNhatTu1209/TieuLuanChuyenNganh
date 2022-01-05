import { useEffect, useState } from "react";
import "./App.css";
import Router from "./route";
import "bootstrap/dist/css/bootstrap.min.css";
import { ToastContainer } from "react-toastify";
import SocketService from "./socket/baseSocket";
import "react-toastify/dist/ReactToastify.css";
import io from "socket.io-client";
import { Trans, useTranslation } from "react-i18next";

function App() {
  const token = localStorage.getItem("token");
  const connectSocket = async (url: string) => {
    const socket = await SocketService.connect(url).catch((err) => {
      console.log("Error: ", err);
    });
  };

  useEffect(() => {
    if (token) {
      // console.log(`123`, token);
      const urlSocket = `https://befreshfood.tk/?token=Bearer ${token}`;
      connectSocket(urlSocket);
    }
  }, [token]);

  return (
    <div>
      <Router></Router>
      <ToastContainer
        position="top-right"
        autoClose={2000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
      />
    </div>
  );
}

export default App;
