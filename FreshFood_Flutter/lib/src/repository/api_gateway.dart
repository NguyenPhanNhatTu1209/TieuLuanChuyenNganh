class ApiGateway {
// Authentication
  static const LOGIN = 'user/login';
  static const LOGIN_WITH_GOOGLE = 'user/loginGoogle';
  static const REGISTER = 'user/register';
  static const FORGOTPASSWORD = 'user/forgotPassword';
  static const CONFIRMOTP = 'user/confirmOtp';
  static const CHANGEPASSWORDWITHOTP = 'user/changePasswordWithOtp';
  static const CHANGE_PASSWORD = 'user/changePassword';

  static const READ = '/read';
  static const DELETE = '/read';

  //Group Product
  static const GETGROUPPRODUCT = 'groupProduct/getAllGroupProduct';

  //Cart
  static const GETCART = 'cart/getAllCart';
  static const ADD_TO_CART = 'cart/createCart';
  static const UPDATE_CART = 'cart/updateCart';

  //order
  static const CREATE_ORDER = 'order/createOrder';
  static const CREATE_ORDER_BUY_NOW = 'order/CreateOrderWithByNow';
  static const GET_ORDER = 'order/getOrders';
  static const GET_ORDER_ADMIN = 'order/getOrdersByAdmin';
  static const UPDATE_STATUS_ORDER = 'order/updateStatusOrder';

  //product
  static const GET_DETAIL_PRODUCT = 'product/getDetailProduct';
  static const GET_RECOMMEND = 'product/getProductRecommend';
  static const CREATE_PRODUCt = 'product/createProduct';
  static const GET_ALL_PRODUCT = 'product/findAllProduct';
  static const UPDATE_PRODUCT = 'product/updateProduct';
  //productUser
  static const PRODUCT_USER = 'productUser/getAllProductUser';
  static const CREATE_PRODUCT_USER = 'productUser/createProductUser';

  //user
  static const GET_PROFILE = 'user/getInformation';
  static const UPDATE_IMAGE = 'user/updateImage';
  static const GET_MESSAGE = 'chat/getMessage';
  static const UPDATE_PROFILE = 'user/updateInformation';

  //address
  static const GET_ADDRESS = 'address/getAllAddress';
  static const ADD_ADDRESS = 'address/createAddress';
  static const UPDATE_ADDRESS = 'address/updateAddress';
  static const DELETE_ADDRESS = 'address/deleteAddress';
  //admin
  static const GET_ALL_USER = 'user/getAllUser';
  static const GET_LiST_ROOM = 'chat/getRoom';
  static const GET_STATISTIC_ORDER = 'statistic/getStatisticByOrderMobile';
  static const GET_STATISTIC_PRODUCT = 'statistic/getStatisticByProduct';
  static const GET_STATISTIC_USER = 'statistic/getStatisticByUser';
  static const GET_AVATAR_ADMIN = 'user/getAvatarAdmin';
  static const GET_USER_BY_ID = 'user/getInformationById';
  static const CREATE_STAFF = 'user/createStaff';

  //eveluate
  static const GET_EVELUATE = 'eveluate/getEveluate';
  static const CREATE_EVELUATE = 'eveluate/createEveluate';

  //discount
  static const GET_ALL_DISCOUNT = 'discount/getAllDiscount';
  static const GET_DISCOUNT_ACTIVE = 'discount/getAllDiscountActive';
  static const CREATE_DISCOUNT = 'discount/createDiscount';

  //Group Question
  static const GET_GROUP_QUESTION = 'groupQuestion/getAllGroupQuestion';
  static const CREATE_GROUP_QUESTION = 'groupQuestion/createGroupQuestion';
  static const UPDATE_GROUP_QUESTION = 'groupQuestion/updateGroupQuestion';

  //Question
  static const GET_ALL_QUESTION = 'question/getAllQuestionByGroup';
  static const CREATE_QUESTION = 'question/createQuestion';
  static const UPDATE_QUESTION = 'question/updateQuestion';

  //Answer
  static const CREATE_ANSWER = 'answer/createAnswer';

  //inventory history
  static const GET_HISTORY_INVENTORY = 'iventoryHistory/getAllIventoryHistory';
  static const CREATE_HISTORY_INVENTORY =
      'iventoryHistory/createIventoryHistory';
}
