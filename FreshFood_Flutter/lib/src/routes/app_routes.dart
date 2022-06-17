part of 'app_pages.dart';

abstract class Routes {
  static const ROOT = '/';
  static const HOME = '/home';
  static const AUTHENTICATION = '/authentication';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PRODUCT = '/product';
  static const PROFILE = '/profile';
  static const DETAIL_PRODUCT = '/detailProduct';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const CHAT = '/chat';
  static const DETAIL_PAYMENT = '/detailPayment';
  static const ADDRESS = '/address';
  static const ADD_ADDRESS = '/addAddress';
  static const UPDATE_ADDRESS = '/updateAddress';
  static const UPDATE_ADDRESS_PAGE_DETAIL = '/updateAddressDetail';
  static const METHOD_PAYMENT = '/methodPayment';
  static const OTP = '/otp';
  static const CHANGEPASSWORDWITHOTP = '/changePasswordWithOtp';
  static const PAYMENT_WEB_PAGE = '/paymentWebPage';
  static const DETAIL_ORDER = '/detailOrder';
  static const HISTORY_ORDER = '/historyOrder';
  static const EVELUATE_DETAIL = '/eveluateDetail';
  static const UPDATE_PRODUCT = '/updateProduct';
  static const CREATE_PRODUCT = '/createProduct';
  static const CREATE_STAFF = '/createStaff';
  static const EVELUATE_PRODUCT = '/eveluateProduct';
  static const ADMIN_WALLET = '/adminVNPayPage';
  static const CHAT_DETAIL = '/ChatDetail';
  static const ADMIN_MANAGER_USER = '/ManagerUser';
  static const ADMIN_MANAGER_PRODUCT = '/ManagerProduct';
  static const ADMIN_MANAGER_ORDER = '/ManagerOrderAdmin';
  static const PAYMENT_SUCCESS = '/PaymentSuccess';
  static const PAYMENT_ERROR = '/PaymentError';
  static const STATISTIC_ORDER = '/SatisticOrder';
  static const DETAIL_INFORMATION_USER = '/DetailInformationUser';
  static const STATISTIC_USER = '/StatisticUser';
  static const MANAGER_STAFF = '/ManagerStaff';
  static const FORGOT_PASSWORD = '/ForgotPassword';
  static const CHANGE_PASSWORD = '/ChangePassword';
  //Discount
  static const MANAGER_DISCOUNT = '/GetAllDiscount';
  static const CREATE_DISCOUNT = '/createDiscount';
  static const APPLY_DISCOUNT = '/appDiscount';

  //Question
  static const CREATE_QUESTION = '/createQuestion';
  static const MANAGER_GROUP_QUESTION = '/managerGroupQuestion';
  static const MANAGER_QUESTION = '/managetQuestion';

  //answer
  static const ANSWER_PAGE = '/answerQuestion';

  //inventory history
  static const CREATE_INVENTORY_HISTORY = '/createInventoryHistory';
  static const MANAGER_INVENTORY_HISTORY = '/inventoryHistory';
  static const DETAIL_MANAGER_INVENTORY_HISTORY = '/detailInventoryHistory';
}
