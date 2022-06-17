import React from "react";
import "./style.scss";
import { AiOutlineCloseCircle } from "react-icons/ai";
interface ModalLMSProps {
  children: Array<React.ReactChild> | React.ReactChild;
  title: string;
  withHeader: boolean;
  cancel: Function;
}

export const ModalLMS = (props: ModalLMSProps) => {
  return (
    <div className="modalLMS">
      <div className="modalLMS-overlay"></div>
      <div className="modalLMS-wrapper" style={{ overflow: "auto" }}>
        {props.withHeader ? (
          <div className="modalLMS-header">
            <div className="modalLMS-title">
              <h3>{props.title}</h3>
            </div>
            <div className="modalLMS-close" onClick={() => props.cancel()}>
              <AiOutlineCloseCircle />
            </div>
          </div>
        ) : (
          ""
        )}

        <div className="modalLMS-content ">{props.children}</div>
      </div>
    </div>
  );
};

<div className="modal">
  <div className="modal-container">
    <div className="modal-close">X</div>
    <div className="modal-content">your content</div>
  </div>
</div>;
