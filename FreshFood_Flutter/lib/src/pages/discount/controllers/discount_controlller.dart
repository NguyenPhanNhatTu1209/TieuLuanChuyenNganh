import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/discount.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/payment/controller/addressController.dart';
import 'package:freshfood/src/pages/payment/controller/payment_controller.dart';
import 'package:freshfood/src/repository/discount_repository.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DiscountController extends GetxController {
  int skip = 1;
  List<dynamic> listDiscount = [];
  DateTime startTime;
  DateTime endTime;
  DiscountModel currentDiscount;
  int indexSelected = -1;
  int moneyDiscount = 0;
  PaymentController paymentController = Get.put(PaymentController());

  initialController() {
    listDiscount = [];
    skip = 1;
  }

  getAllDiscount() {
    if (skip != -1) {
      DiscountRepository().getAllDiscount(skip, 10).then((value) {
        if (value != null) {
          listDiscount.addAll(value);
          skip++;
          update();
        } else {
          skip = -1;
          update();
        }
      });
    }
  }

  getDiscountActive() {
    DiscountRepository().getDiscountActive().then((value) {
      if (value != null) {
        listDiscount.addAll(value);
        for (var item in listDiscount) {
          if (item['minimumDiscount'] < paymentController.productPrice)
            item['active'] = true;
        }
        update();
      }
    });
  }

  initDateTime() {
    startTime = DateTime.now();
    endTime = DateTime.now();
  }

  setStartTime(DateTime picked) {
    startTime = picked;
    update();
  }

  setEndTime(DateTime picked) {
    endTime = picked;
    update();
  }

  applyDiscount() async {
    if (indexSelected == -1) return;
    if (currentDiscount != null &&
        currentDiscount.id == listDiscount[indexSelected]['_id']) return;

    await paymentController.getMoney();
    currentDiscount = DiscountModel.fromMap(listDiscount[indexSelected]);
    moneyDiscount =
        paymentController.productPrice * currentDiscount.percentDiscount ~/ 100;
    if (moneyDiscount > currentDiscount.maxDiscount)
      moneyDiscount = currentDiscount.maxDiscount;

    paymentController.isUsePoint = false;
    paymentController.total = paymentController.total - moneyDiscount;
    paymentController.calculatePoint();
    update();
  }

  selectIndexDiscount(int index) {
    indexSelected = index;
    update();
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
          note: paymentController.note,
          typePaymentOrder: paymentController.methodPayment,
          idDiscount: currentDiscount != null ? currentDiscount.id : '',
          bonusMoney:
              paymentController.isUsePoint ? paymentController.usePoint : 0,
        )
            .then((value) {
          Get.back();
          final cartController = Get.put(CartController());
          cartController.getListProduct();
          var temp = paymentController.methodPayment;
          paymentController.methodPayment = 0;
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
          note: paymentController.note,
          typePaymentOrder: paymentController.methodPayment,
          idDiscount: currentDiscount != null ? currentDiscount.id : '',
          bonusMoney:
              paymentController.isUsePoint ? paymentController.usePoint : 0,
        )
            .then((value) {
          final cartController = Get.put(CartController());
          cartController.getListProduct();
          var temp = paymentController.methodPayment;
          paymentController.methodPayment = 0;
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
