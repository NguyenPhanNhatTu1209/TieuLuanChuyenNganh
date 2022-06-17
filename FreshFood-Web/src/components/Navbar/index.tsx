import React, { useRef, useState } from "react";
import { IoMdCart } from "react-icons/io";
import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";
import reactSelectCjs from "react-select";
import { logoutUser } from "../../features/auths/slice";
import { selectCurrentUser } from "../../features/auths/slice/selector";
import { getCurrentUserAsync } from "../../features/auths/slice/thunk";
import { useHistory } from "react-router";

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
  const [isOpen, setIsOpen] = useState(false);
  const { ref, isComponentVisible, setIsComponentVisible } =
    useComponentVisible(true);
  const dispatch = useDispatch();
  const toggleDropdown04 = (e: any) => {
    e.target.className =
      "nav-link dropdown-toggle" === e.target.className
        ? "nav-link dropdown-toggle active"
        : "nav-link dropdown-toggle";
  };

  const blurDropdown04 = (e: any) => {
    e.target.className = "nav-link dropdown-toggle";
  };

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
                    Home
                  </Link>
                </li>
                <li
                  className="nav-item dropdown"
                  tabIndex={0}
                  ref={ref}
                  onClick={() => setIsComponentVisible(true)}
                >
                  <Link
                    className="nav-link dropdown-toggle active"
                    to="#"
                    id="dropdown04"
                  >
                    Shop
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link className="dropdown-item" to="/shop">
                        Product
                      </Link>

                      <Link className="dropdown-item" to="/cart">
                        Cart
                      </Link>
                      <Link className="dropdown-item" to="/checkout">
                        Checkout
                      </Link>
                    </div>
                  )}
                </li>
                <li className="nav-item">
                  <Link to="/order" className="nav-link">
                    Order
                  </Link>
                </li>

                <li className="nav-item">
                  <Link to="/contact" className="nav-link">
                    Contact
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

                    <label className="ms-3 fw-bold" style={{ paddingTop: 20 }}>
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a onClick={handleLogout} style={{ color: "red" }}>
                    Log out
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
                    Analytics
                  </Link>
                </li>
                <li
                  className="nav-item dropdown"
                  // onBlur={blurDropdown04}
                  tabIndex={0}
                  // onClick={toggl`eDropdown04}
                  ref={ref}
                  onClick={() => setIsComponentVisible(true)}
                >
                  <Link
                    className="nav-link dropdown-toggle active"
                    to="#"
                    id="dropdown04"
                  >
                    Product
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link
                        className="dropdown-item"
                        to="/createproduct"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        Create
                      </Link>
                      <Link
                        className="dropdown-item"
                        to="/updateproduct"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        List
                      </Link>
                    </div>
                  )}
                </li>

                <li className="nav-item active">
                  <Link to="/usermanagement" className="nav-link">
                    User Management
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

                    <label className="ms-3 fw-bold" style={{ paddingTop: 20 }}>
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a onClick={handleLogout} style={{ color: "red" }}>
                    Log out
                  </a>
                </li>
              </ul>
            </>
          ) : user?.role === 2 ? (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item">
                  <Link to="/ordermanagement" className="nav-link">
                    Order Management
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

                    <label className="ms-3 fw-bold" style={{ paddingTop: 20 }}>
                      {user?.name}
                    </label>
                  </Link>
                </li>
                <li className="nav-item">
                  <a onClick={handleLogout} style={{ color: "red" }}>
                    Log out
                  </a>
                </li>
              </ul>
            </>
          ) : (
            <>
              <ul className="navbar-nav ml-auto">
                <li className="nav-item active">
                  <Link to="/" className="nav-link">
                    Home
                  </Link>
                </li>
                <li
                  className="nav-item dropdown"
                  // onBlur={blurDropdown04}
                  tabIndex={0}
                  // onClick={toggl`eDropdown04}
                  ref={ref}
                  onClick={() => setIsComponentVisible(true)}
                >
                  <Link
                    className="nav-link dropdown-toggle active"
                    to="#"
                    id="dropdown04"
                  >
                    Shop
                  </Link>
                  {isComponentVisible && (
                    <div className="dropdown-menu" aria-labelledby="dropdown04">
                      <Link
                        className="dropdown-item"
                        to="/shop"
                        onClick={() => setIsComponentVisible(false)}
                      >
                        Product
                      </Link>
                    </div>
                  )}
                </li>

                <li className="nav-item">
                  <Link to="/contact" className="nav-link">
                    Contact
                  </Link>
                </li>
                <li className="nav-item">
                  <Link to="/signin" className="nav-link">
                    SignIn
                  </Link>
                </li>
                <li className="nav-item">
                  <Link to="/signup" className="nav-link">
                    SignUp
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
