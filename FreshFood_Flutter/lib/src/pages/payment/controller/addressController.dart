import 'package:freshfood/src/models/address.dart';
import 'package:freshfood/src/pages/payment/controller/payment_controller.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  List<AddressModel> listAddress = [];
  AddressModel addressSelected;
  getAllAddress() {
    UserRepository().getAllAddress().then((value) {
      if (value.isNotEmpty) {
        listAddress = value.map((data) => AddressModel.fromMap(data)).toList();

        if (value.length == 1) {
          addressSelected = listAddress[0];
        } else {
          addressSelected =
              listAddress.firstWhere((element) => element.isMain == true);
        }

        final paymentController = Get.put(PaymentController());
        paymentController.getMoney();
        update();
      }
    });
  }

  setAddress({String id = ''}) {
    addressSelected = listAddress.firstWhere((element) => element.id == id);
    final paymentController = Get.put(PaymentController());
    paymentController.getMoney();
    update();
  }
}
