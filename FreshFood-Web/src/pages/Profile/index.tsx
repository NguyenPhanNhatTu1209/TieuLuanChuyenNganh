import React, { useRef, useState } from "react";
import { useForm } from "react-hook-form";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router";
import { updateAvatarApi } from "../../apis/auths/updateAvatar.api";
import { changeUser } from "../../features/auths/slice";
import { selectCurrentUser } from "../../features/auths/slice/selector";
import { notifySuccess } from "../../utils/notify";
import ModalChangePass from "./components/ModalChangePass";
import ModalChangeInfo from "./components/ModalChangInfo";
import "./style.scss";

interface ProfilePageProps {}

export const ProfilePage = (props: ProfilePageProps) => {
  const [open, setOpen] = useState(false);
  const dispatch = useDispatch();
  const refAvatar = useRef<HTMLImageElement>(null);
  const handdleOpen = () => {
    setOpen(true);
  };
  const handdleCancel = () => {
    setOpen(false);
  };
  const [open2, setOpen2] = useState(false);
  const handdleOpen2 = () => {
    setOpen2(true);
  };
  const handdleCancel2 = () => {
    setOpen2(false);
  };
  const history = useHistory();

  const user = useSelector(selectCurrentUser);
  const onChangeAvatar = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files?.length > 0) {
      const file = e.target.files[0];
      const result = await updateAvatarApi({ avatar: file });
      console.log(result);
      if (result.statusCode === 200) {
        notifySuccess("Đã cập nhật ảnh đại diện");
        dispatch(changeUser(result.data));
      }
    }
  };
  console.log(user);

  const { t, i18n } = useTranslation();

  return (
    <div className="profilePage container">
      <div className="profilePage-wrapper">
        <div className="profilePage-wrapper-headerBackground"></div>
        <label htmlFor="avatar">
          <div className="profilePage-wrapper-avatar">
            <img src={user?.avatar} alt="" ref={refAvatar} />
          </div>
        </label>
        <input
          type="file"
          name="avatar"
          id="avatar"
          hidden
          onChange={onChangeAvatar}
        />
        <div className="profilePage-wrapper-bottomBackground">
          <div className="signInPage-form-content">
            <h3>
              {t("profile.Name")}{" "}
              <span style={{ color: "#82ae46" }}>{user?.name}</span>
            </h3>

            <h3>
              {t("profile.Phone")}{" "}
              <span style={{ color: "#82ae46" }}>{user?.phone}</span>
            </h3>

            <button
              onClick={handdleOpen}
              id="changeinfo"
              className="btn btn-block login-btn mb-4"
              type="submit"
              style={{
                backgroundColor: "#82ae46",
                color: "white",
              }}
            >
              {t("profile.Modal1.Title")}
            </button>
            <button
              onClick={handdleOpen2}
              id="changpassword"
              className="btn btn-block login-btn mb-4"
              type="submit"
              style={{
                backgroundColor: "#82ae46",
                color: "white",
              }}
            >
              {t("profile.Modal2.Title")}
            </button>
          </div>
          <ModalChangeInfo open={open} cancel={handdleCancel} />
          <ModalChangePass open2={open2} cancel2={handdleCancel2} />
        </div>
      </div>
    </div>
  );
};
