import React, { useState } from "react";
import { Table } from "react-bootstrap";
import { useTranslation } from "react-i18next";
import { useDispatch, useSelector } from "react-redux";
import { getAllUserApi } from "../../../apis/user/getAllUser.api";
import { getDetailUser } from "../../../features/user/slice";
import { selectAllUser } from "../../../features/user/slice/selector";
import { getAllUserAsync } from "../../../features/user/slice/thunk";
import ModalInfo from "./components/ModalInfo";
import "./style.scss";

interface userManagementProps {}

const UserManagement = (props: userManagementProps) => {
  const [open, setOpen] = useState(false);
  const [user, setUser] = React.useState<any>([]);
  const [active, setActive] = useState(false);
  const dispatch = useDispatch();

  const handleOpen = (data: any) => {
    dispatch(getDetailUser(data));
    setOpen(true);
  };

  const handleCancel = () => {
    setOpen(false);
  };
  const allUser = useSelector(selectAllUser) || [];
  React.useEffect(() => {
    dispatch(getAllUserAsync({ skip: 1, limit: 10, role: 0 }));
  }, []);

  const handleChangeRole = (value: boolean) => {
    setActive(value);
    dispatch(getAllUserAsync({ skip: 1, limit: 10, role: value ? 2 : 0 }));
  };

  const { t, i18n } = useTranslation();
  return (
    <div className="userManagement container">
      <div className="roleChoose d-flex ">
        <a
          className={`roleChoose-role ${!active ? "active" : ""}`}
          onClick={() => handleChangeRole(false)}
        >
          {t("admin.UserManagement.Button1")}
        </a>
        <a
          className={`roleChoose-role ${active ? "active" : ""}`}
          onClick={() => handleChangeRole(true)}
        >
          {t("admin.UserManagement.Button2")}
        </a>
      </div>

      <Table striped bordered hover>
        <thead>
          <tr>
            <th>#</th>
            <th>Email</th>
            <th>{t("admin.UserManagement.Title")}</th>
          </tr>
        </thead>
        <tbody>
          {allUser.map((item: any, i: number) => (
            <tr key={i}>
              <td>{i}</td>
              <td id="userManagement-email" onClick={() => handleOpen(item)}>
                {item.email}
              </td>
              <td>{item.phone}</td>
            </tr>
          ))}
        </tbody>
      </Table>
      <ModalInfo open={open} cancel={handleCancel} />
    </div>
  );
};

export default UserManagement;
