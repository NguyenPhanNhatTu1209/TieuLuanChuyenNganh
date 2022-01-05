import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import { ForbiddenLMS } from "../components/403";
import { FooterPage } from "../components/Footer";
import Navbar from "../components/Navbar";
import { PrivateRoute } from "../components/PrivateRoute";
import Subcribe from "../components/Subcribe";
import { DFRole } from "../Constant/DFRole";
import Analytics from "../pages/Admin/Analytics";
import AdminChat from "../pages/Admin/Chat";
import CreateProductPage from "../pages/Admin/CreateProduct";
import DetailProduct from "../pages/Admin/DetailProduct";
import UpdateProduct from "../pages/Admin/UpdateProduct";
import UserManagement from "../pages/Admin/UserManagement";
import userManagement from "../pages/Admin/UserManagement";

import { Cart } from "../pages/Cart";

import CheckoutPage from "../pages/Checkout";
import { Contact } from "../pages/Contact";
import { ForgotPass } from "../pages/ForgotPass";
import HomePage from "../pages/HomePage";
import OrderPage from "../pages/Order";
import OrderManagement from "../pages/OrderManagement";
import { ProfilePage } from "../pages/Profile";
import { ResetPass } from "../pages/ResetPass";
import ShopPage from "../pages/Shop";
import { SignIn } from "../pages/SignIn";
import { SignUp } from "../pages/SignUp";
import SingleProductPage from "../pages/SingleProduct";
import WishListPage from "../pages/WishList";
import { defaultRoute } from "./defaultroute";

interface IRoute {
  exact: Boolean;
  path: string;
  child: React.ReactChild | any;
}

interface IPrivateRoute {
  exact: Boolean;
  path: string;
  child: React.ReactChild | any;
  private?: Boolean;
  option: boolean;
  roleRoute?: Array<number>;
}

const routes: Array<IRoute> = [
  {
    child: (
      <>
        <ShopPage />
      </>
    ),
    path: defaultRoute.shoppage,
    exact: true,
  },
  {
    child: (
      <>
        <SingleProductPage />
      </>
    ),
    path: defaultRoute.singleproduct,
    exact: true,
  },
  {
    child: (
      <>
        <HomePage />
      </>
    ),
    path: defaultRoute.homepage,
    exact: true,
  },
  {
    child: (
      <>
        <SignIn />
      </>
    ),
    path: defaultRoute.signin,
    exact: true,
  },
  {
    child: (
      <>
        <SignUp />
      </>
    ),
    path: defaultRoute.signup,
    exact: true,
  },
  {
    child: (
      <>
        <ForgotPass />
      </>
    ),
    path: defaultRoute.forgotpass,
    exact: true,
  },
  {
    child: (
      <>
        <Contact />
      </>
    ),
    path: defaultRoute.contact,
    exact: true,
  },
];

const routesPrivate = [
  {
    child: <UserManagement />,
    path: defaultRoute.usermanagement,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin],
  },
  {
    child: <UpdateProduct />,
    path: defaultRoute.updateproduct,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin],
  },
  {
    child: <CreateProductPage />,
    path: defaultRoute.createproduct,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin],
  },
  {
    child: <Analytics />,
    path: defaultRoute.analytics,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin],
  },
  {
    child: <DetailProduct />,
    path: defaultRoute.detailproduct,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin],
  },
  {
    child: <AdminChat />,
    path: defaultRoute.adminchat,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin, DFRole.User],
  },
  {
    child: <ResetPass />,
    path: defaultRoute.resetpass,
    exact: true,
    option: true,
    roleRoute: [DFRole.Admin, DFRole.User, DFRole.Staff],
  },
  {
    child: <OrderPage />,
    path: defaultRoute.order,
    exact: true,
    option: true,
    roleRoute: [DFRole.User],
  },
  {
    child: <WishListPage />,
    path: defaultRoute.wishlist,
    exact: true,
    option: true,
    roleRoute: [DFRole.User],
  },

  {
    child: <CheckoutPage />,
    path: defaultRoute.checkout,
    exact: true,
    option: true,
    roleRoute: [DFRole.User],
  },
  {
    child: <Cart />,
    path: defaultRoute.cart,
    exact: true,
    option: true,
    roleRoute: [DFRole.User],
  },
  {
    child: <ProfilePage />,
    path: defaultRoute.profile,
    exact: true,
    option: true,
    roleRoute: [DFRole.User, DFRole.Staff, DFRole.Admin],
  },
  {
    child: <OrderManagement />,
    path: defaultRoute.ordermanagement,
    exact: true,
    option: true,
    roleRoute: [DFRole.Staff],
  },
];

const renderPrivateRoute = (routes: Array<IPrivateRoute>) => {
  return routes.map((r, i) => {
    if (r.exact) {
      return (
        <PrivateRoute
          path={r.path}
          exact
          key={i}
          option={r.option}
          roleRoute={r?.roleRoute}
        >
          {r.child}
        </PrivateRoute>
      );
    } else {
      return (
        <PrivateRoute
          path={r.path}
          key={i}
          option={r.option}
          roleRoute={r?.roleRoute}
        >
          {r.child}
        </PrivateRoute>
      );
    }
  });
};

const renderRoute = (routes: Array<IRoute>) => {
  return routes.map((r, i) => {
    if (r.exact) {
      return (
        <Route path={r.path} exact key={i}>
          {r.child}
        </Route>
      );
    } else {
      return (
        <Route path={r.path} key={i}>
          {r.child}
        </Route>
      );
    }
  });
};

const Router = () => {
  return (
    <BrowserRouter>
      <Navbar />
      <Switch>
        {renderRoute(routes)}
        {renderPrivateRoute(routesPrivate)}
        <Route path="*">
          <ForbiddenLMS />
        </Route>
      </Switch>
      <Subcribe />
      <FooterPage />
    </BrowserRouter>
  );
};

export default Router;
