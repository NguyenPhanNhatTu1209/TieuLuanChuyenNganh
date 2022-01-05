import React from "react";
import "./style.scss";

interface LoadingProps {
  loading: boolean;
}

export const LoadingLMS = (props: LoadingProps) => {
  if (props.loading)
    return (
      <div className="loadingContainer">
        <span className="loader">
          <span className="loader-text">F</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">R</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">E</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">S</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">H</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">F</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">O</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">O</span>
          <span className="loader-inner"></span>
        </span>
        <span className="loader">
          <span className="loader-text">D</span>
          <span className="loader-inner"></span>
        </span>
      </div>
    );
  return <></>;
};
