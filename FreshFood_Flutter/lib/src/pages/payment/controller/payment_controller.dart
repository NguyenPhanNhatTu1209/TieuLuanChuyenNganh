import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';

import 'addressController.dart';

class PaymentController extends GetxController {
  double total = 0;
  double transportFee = 0;
  double productPrice = 0;
  int methodPayment = 0;
  List<CartModel> list = [];
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

  getMoney() {
    final addressController = Get.put(AddressController());
    double weight = 0;
    list.forEach((element) {
      weight += element.weight;
    });
    OrderRepository()
        .getShipFee(
            address: addressController.addressSelected.address,
            province: addressController.addressSelected.province,
            district: addressController.addressSelected.district,
            weight: weight)
        .then((value) {
      transportFee = double.parse(value.toString());
      total = transportFee + productPrice;
      update();
    });
  }

  createOrder(List<CartModel> list, bool isBuyNow) {
    final addressController = Get.put(AddressController());
    if (addressController.addressSelected != null) {
      List<String> id = list.map((value) => value.id).toList();
      if (isBuyNow == false) {
        OrderRepository()
            .createOrder(
                cartId: id,
                address: addressController.addressSelected,
                note: note,
                typePaymentOrder: methodPayment)
            .then((value) {
          Get.back();
          print(value['link']);
          final cartController = Get.put(CartController());
          cartController.getListProduct();
          var temp = methodPayment;
          methodPayment = 0;
          if (temp != 0) {
            Get.toNamed(Routes.PAYMENT_WEB_PAGE,
                arguments: {"link": value['link']});
          } else {
            Get.offAllNamed(Routes.ROOT);
            GetSnackBar getSnackBar = GetSnackBar(
              title: 'Tạo đơn hàng thành công',
              subTitle: 'Bạn có thể theo dõi quá trình vận đơn tại mục Xem đơn',
            );
            getSnackBar.show();
          }
        });
      } else {
        OrderRepository()
            .createOrderBuyNow(
                productId: list[0].id,
                quantity: list[0].quantity,
                address: addressController.addressSelected,
                note: note,
                typePaymentOrder: methodPayment)
            .then((value) {
          print(value['link']);
          final cartController = Get.put(CartController());
          cartController.getListProduct();
          var temp = methodPayment;
          methodPayment = 0;
          if (temp != 0) {
            Get.toNamed(Routes.PAYMENT_WEB_PAGE,
                arguments: {"link": value['link']});
          } else {
            Get.offAllNamed(Routes.ROOT);
            GetSnackBar getSnackBar = GetSnackBar(
              title: 'Tạo đơn hàng thành công',
              subTitle: 'Bạn có thể theo dõi quá trình vận đơn tại mục Xem đơn',
            );
            getSnackBar.show();
          }
        });
      }
    } else {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Tạo đơn hàng thất bại',
        subTitle: 'Vui lòng chọn địa chỉ nhận hàng!',
      );
      getSnackBar.show();
    }
  }
}
