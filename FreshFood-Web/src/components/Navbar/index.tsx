import React, { useRef, useState } from "react";
import { useTranslation } from "react-i18next";
import { IoMdCart } from "react-icons/io";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router";
import { Link } from "react-router-dom";
import { logoutUser } from "../../features/auths/slice";
import { selectCurrentUser } from "../../features/auths/slice/selector";
import { getCurrentUserAsync } from "../../features/auths/slice/thunk";
import "./style.scss";

function useComponentVisible(initialIsVisible: any) {
  const [isComponentVisible, setIsComponentVisible] =
    useState(initialIsVisible);
  const ref = useRef<any>(null);

  const handleClickOutside = (event: any) => {
    if (ref.current && !ref.current.contains(event.target)) {
      setIsComponentVisible(false);
    }
  };

  React.useEffect(() => {
    document.addEventListener("click", handleClickOutside, true);
    return () => {
      document.removeEventListener("click", handleClickOutside, true);
    };
  });

  return { ref, isComponentVisible, setIsComponentVisible };
}

const Navbar = () => {
  const { t, i18n } = useTranslation();

  const { ref, isComponentVisible, setIsComponentVisible } =
    useComponentVisible(false);
  const dispatch = useDispatch();

  const history = useHistory();
  const user = useSelector(selectCurrentUser);
  const handleLogout = () => {
    dispatch(logoutUser());
    history.push("/");
  };
  React.useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      dispatch(getCurrentUserAsync());
    }
  }, []);

  const changeLanguage = (language: any) => {
    i18n.changeLanguage(language);
  };

  return (
    <nav
      className="
        navbar navbar-expand-lg
        ftco_navbar
        ftco-navbar-light
    "
      id="ftco-navbar"
    >
      <div className="container">
        <Link className="navbar-brand" to="/">
          Freshfoods
        </Link>
        <button
          onClick={() => changeLanguage("en")}
          className="btn btn-success"
          style={{ backgroundColor: "#82ae46", marginLeft: "10px" }}
        >
          EN
        </button>
        <button
          onClick={() => changeLanguage("vi")}
          className="btn btn-success"
          style={{ backgroundColor: "#82ae46" }}
        >
          VN
        </button>
        <button
          className="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#ftco-nav"
          aria-controls="ftco-nav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="oi oi-menu"></span> Menu
        </button>

        <div className="collapse navbar-collapse" id="ftco-nav">
          {user?.role == 0 ? (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item active">
                  <Link to="/" className="nav-link">
                    {t("navbar.Home")}
                  </Link>
                </li>
                <li className="nav-item active">
                  <Link to="/adminchat" className="nav-link">
                    {t("navbar.Chat")}
                  </Link>
                </li>
                <li className="nav-item dropdown" tabIndex={0} ref={ref}>
                  <Link
                    className="nav-link dropdown-toggle active"
                    to="#"
                    id="dropdown04"
                    onClick={() => setIsComponentVisible(true)}
                  >
                    {t("navbar.Shop")}
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link
                        className="dropdown-item"
                        to="/shop"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.Product")}
                      </Link>

                      <Link
                        className="dropdown-item"
                        to="/cart"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.Cart")}
                      </Link>
                      <Link
                        className="dropdown-item"
                        to="/checkout"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.CheckOut")}
                      </Link>
                    </div>
                  )}
                </li>
                <li className="nav-item">
                  <Link
                    to="/order"
                    className="nav-link"
                    onClick={() => setIsComponentVisible(false)}
                  >
                    {t("navbar.Order")}
                  </Link>
                </li>

                <li className="nav-item">
                  <Link
                    to="/contact"
                    className="nav-link"
                    onClick={() => setIsComponentVisible(false)}
                  >
                    {t("navbar.Contact")}
                  </Link>
                </li>
                <li className="nav-item flex">
                  <Link className="nav-link " to="/profile">
                    <img
                      src={user?.avatar}
                      height={50}
                      width={50}
                      style={{ borderRadius: "50%" }}
                    />

                    <label
                      id="nav-userName"
                      className="ms-3 fw-bold"
                      style={{ paddingTop: 20 }}
                    >
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a
                    id="nav-logOut"
                    onClick={handleLogout}
                    style={{
                      color: "red",
                      fontFamily: "Poppins",
                      fontSize: "14px",
                      fontWeight: 400,
                    }}
                  >
                    {t("navbar.Logout")}
                  </a>
                </li>

                <li className="nav-item cta cta-colored">
                  <Link to="/cart" className="nav-link">
                    <IoMdCart />
                    {/* <span className='icon-shopping_cart'></span>[0] */}
                  </Link>
                </li>
              </ul>
            </>
          ) : user?.role === 1 ? (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item active">
                  <Link to="/analytics" className="nav-link">
                    {t("navbar.Analytics")}
                  </Link>
                </li>
                <li className="nav-item dropdown" tabIndex={0} ref={ref}>
                  <Link
                    className="nav-link dropdown-toggle active"
                    onClick={() => setIsComponentVisible(true)}
                    to="#"
                    id="dropdown04"
                  >
                    {t("navbar.Product")}
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link
                        className="dropdown-item"
                        to="/createproduct"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.Create")}
                      </Link>
                      <Link
                        className="dropdown-item"
                        to="/updateproduct"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.List")}
                      </Link>
                    </div>
                  )}
                </li>

                <li className="nav-item active">
                  <Link to="/usermanagement" className="nav-link">
                    {t("navbar.UserManagement")}
                  </Link>
                </li>
                <li className="nav-item active">
                  <Link to="/adminchat" className="nav-link">
                    {t("navbar.Chat")}
                  </Link>
                </li>

                <li className="nav-item flex">
                  <Link className="nav-link " to="/profile">
                    <img
                      src={user?.avatar}
                      height={50}
                      width={50}
                      style={{ borderRadius: "50%" }}
                    />

                    <label
                      id="nav-userName"
                      className="ms-3 fw-bold"
                      style={{ paddingTop: 20 }}
                    >
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a
                    id="nav-logOut"
                    onClick={handleLogout}
                    style={{
                      color: "red",
                      fontFamily: "Poppins",
                      fontSize: "14px",
                      fontWeight: 400,
                    }}
                  >
                    {t("navbar.Logout")}
                  </a>
                </li>
              </ul>
            </>
          ) : user?.role === 2 ? (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item">
                  <Link to="/ordermanagement" className="nav-link">
                    {t("navbar.OrderManagement")}
                  </Link>
                </li>
                <li className="nav-item flex">
                  <Link className="nav-link " to="/profile">
                    <img
                      src={user?.avatar}
                      height={50}
                      width={50}
                      style={{ borderRadius: "50%" }}
                    />

                    <label
                      id="nav-userName"
                      className="ms-3 fw-bold"
                      style={{ paddingTop: 20 }}
                    >
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a
                    id="nav-logOut"
                    onClick={handleLogout}
                    style={{
                      color: "red",
                      fontFamily: "Poppins",
                      fontSize: "14px",
                      fontWeight: 400,
                    }}
                  >
                    {t("navbar.Logout")}
                  </a>
                </li>
              </ul>
            </>
          ) : (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item active">
                  <Link to="/" className="nav-link">
                    {t("navbar.Home")}
                  </Link>
                </li>
                <li className="nav-item dropdown" tabIndex={0} ref={ref}>
                  <Link
                    onClick={() => setIsComponentVisible(true)}
                    className="nav-link dropdown-toggle active"
                    to="#"
                    id="dropdown04"
                  >
                    {t("navbar.Shop")}
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link
                        className="dropdown-item"
                        to="/shop"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        {t("navbar.Product")}
                      </Link>
                    </div>
                  )}
                </li>

                <li className="nav-item">
                  <Link to="/contact" className="nav-link">
                    {t("navbar.Contact")}
                  </Link>
                </li>
                <li className="nav-item">
                  <Link to="/signin" className="nav-link">
                    {t("navbar.Login")}
                  </Link>
                </li>
                <li className="nav-item">
                  <Link to="/signup" className="nav-link">
                    {t("navbar.Signup")}
                  </Link>
                </li>
              </ul>
            </>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
