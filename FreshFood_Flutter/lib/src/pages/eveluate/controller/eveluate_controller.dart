import 'package:freshfood/src/models/address.dart';
import 'package:freshfood/src/models/create_eveluate_model.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/order/controller/order_controller.dart';
import 'package:freshfood/src/pages/payment/controller/payment_controller.dart';
import 'package:freshfood/src/repository/eveluate_repository.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';

class EveluateController extends GetxController {
  List<EveluateModel> listEveluate = [];
  getAllEveluate(String productId, int skip, int limit) {
    EveluateRepository()
        .getEveluateByProduct(productId: productId, skip: skip, limit: limit)
        .then((value) {
      if (value.isNotEmpty) {
        listEveluate =
            value.map((data) => EveluateModel.fromMap(data)).toList();
        update();
      }
    });
  }

  createEveluate(List<EveluateModel> listProduct) {
    EveluateRepository()
        .createEveluate(
            product: listProduct
                .map(
                    (data) => CreateEveluateModel.fromMap(data.toMap()).toMap())
                .toList())
        .then((value) {
      Get.back();
      if (value.isNotEmpty) {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Đánh giá thành công',
          subTitle: '',
        );
        final orderController = Get.put(OrderController());
        orderController.getOrder(search: '', limit: 10, skip: 1);
        Get.back();
        getSnackBar.show();
        Get.currentRoute == Routes.DETAIL_ORDER
            ? Get.back()
            : null; // do nothing
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Đánh giá thất bại',
          subTitle: '',
        );
        getSnackBar.show();
      }
    });
  }
}
