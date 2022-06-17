import 'dart:io';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/services/upload_storage.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileController extends GetxController {
  // UserModel user = userProvider.user;
  // getProfile() {
  //   // UserRepository().getProfile().then((value) {
  //   //   if (value.isNotEmpty) {
  //   //     user = UserModel.fromMap(value);
  //   //     update();
  //   //   }
  //   // });
  //   user = userProvider.user;
  //   update();
  // }

  updateAvatar(File image) async {
    String url =
        await StorageService().uploadImageToStorage(image, folderAvatar);
    UserRepository().updateImage(avatar: url).then((value) {
      Get.back();
      Get.back();
      if (value == false) {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Thất bại',
          subTitle: 'Cập nhật avatar thất bại',
        );
        getSnackBar.show();
      } else {
        userProvider.user.avatar = url;
        userProvider.setUserProvider(userProvider.user);
        update();
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Thành công',
          subTitle: 'Cập nhật avatar thành công',
        );
        getSnackBar.show();
      }
    });
  }
}
