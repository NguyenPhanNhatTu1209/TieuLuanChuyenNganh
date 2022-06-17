import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:get/get.dart';
import 'addressController.dart';

class PaymentController extends GetxController {
  double total = 0;
  double transportFee = 0;
  double productPrice = 0;
  int methodPayment = 0;
  List<CartModel> list = [];
  double usePoint = 0;
  bool isUsePoint = false;
  String note = '';
  double getproductPrice(List<CartModel> list) {
    productPrice = 0;
    list.forEach((element) {
      productPrice += element.cost * element.quantity;
    });
    return productPrice;
  }

  initPaymentController(List<CartModel> listProduct) {
    list = listProduct;
    usePoint = 0;
  }

  changeStatusUsePoint() {
    isUsePoint = !isUsePoint;
    isUsePoint ? total -= usePoint : total += usePoint;
    update();
  }

  String getPaymentMethod() {
    String temp;
    switch (methodPayment) {
      case 1:
        temp = "Paypal";
        break;

      case 2:
        temp = "VNPay";
        break;
      case 0:
        temp = "Thanh toán khi nhận hàng";
        break;
    }
    return temp;
  }

  changePaymentMethod(int value) {
    methodPayment = value;
    update();
  }

  getMoney() async {
    final addressController = Get.put(AddressController());
    double weight = 0;
    list.forEach((element) {
      weight += element.weight;
    });
    await OrderRepository()
        .getShipFee(
            address: addressController.addressSelected.address,
            province: addressController.addressSelected.province,
            district: addressController.addressSelected.district,
            weight: weight)
        .then((value) {
      transportFee = double.parse(value.toString());
      total = transportFee + productPrice;
      isUsePoint = false;
      calculatePoint();
      update();
    });
  }

  calculatePoint() {
    if (userProvider.user.point == null || userProvider.user.point == 0) return;

    var temp = total / 2;
    if (temp > userProvider.user.point) {
      usePoint = userProvider.user.point.toDouble();
    } else {
      usePoint = temp;
    }
  }
}
