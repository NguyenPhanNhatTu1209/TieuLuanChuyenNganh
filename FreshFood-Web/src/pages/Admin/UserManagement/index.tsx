import { iteratorSymbol } from "immer/dist/internal";
import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { getAllUserApi } from "../../../apis/user/getAllUser.api";
import { getDetailUser } from "../../../features/user/slice";
import ModalInfo from "./components/ModalInfo";

interface userManagementProps {}

const UserManagement = (props: userManagementProps) => {
  const [open, setOpen] = useState(false);
  const dispatch = useDispatch();
  const handleOpen = (data: any) => {
    dispatch(getDetailUser(data));
    setOpen(true);
  };
  const handleCancel = () => {
    setOpen(false);
  };
  const [user, setUser] = React.useState([]);
  React.useEffect(() => {
    (async () => {
      const result = await getAllUserApi();
      console.log(result);
      const { data } = result;
      setUser(data);
    })();
  }, []);

  return (
    <div className="userManagement container">
      <table className="table">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Email</th>
            <th scope="col">Phone</th>
          </tr>
        </thead>
        <tbody>
          {user.map((item: any, i: number) => (
            <tr key={i}>
              <th scope="row" style={{ verticalAlign: "middle" }}>
                {i}
              </th>
              <td onClick={() => handleOpen(item)}>{item.email}</td>
              <td>{item.phone}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <ModalInfo open={open} cancel={handleCancel} />
    </div>
  );
};

export default UserManagement;
