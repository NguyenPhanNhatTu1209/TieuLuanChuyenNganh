import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Redirect, Route, RouteProps, useHistory } from "react-router-dom";
import { DFRole } from "../Constant/DFRole";
import { selectCurrentUser } from "../features/auths/slice/selector";
import { getCurrentUserAsync } from "../features/auths/slice/thunk";
import { LoadingLMS } from "./Loading";

interface IPrivateRoute extends RouteProps {
  option: boolean;
  roleRoute?: Array<number>;
}
export const PrivateRoute = (props: IPrivateRoute) => {
  const { option, roleRoute } = props;
  // console.log("asd", roleRoute);
  const dispatch = useDispatch();
  const history = useHistory();

  const user = useSelector(selectCurrentUser);
  const [acceptRoute, setAcceptRoute] = useState(false);

  const fetchAuth = async () => {
    const res: any = await dispatch(getCurrentUserAsync());
    // console.log("123", res);
    if (res && !res.payload) {
      if (option) {
        history.push("/login");
      }
    } else {
      //đã đăng nhập
      if (roleRoute && !roleRoute.includes(res.payload.role)) {
        //Kiểm tra khong phai admin
        history.push("/");
      } else {
        if (option === false) {
          history.push("/");
        }
      }
    }
    setAcceptRoute(true);
  };
  React.useEffect(() => {
    fetchAuth();
    //To know my current status, send Auth request
  }, []);

  // const isLoggedIn = localStorage.getItem('token')
  // if (!isLoggedIn) return <Redirect to='/' />
  if (acceptRoute) return <Route {...props} />;
  return <LoadingLMS loading={true} />;
};
