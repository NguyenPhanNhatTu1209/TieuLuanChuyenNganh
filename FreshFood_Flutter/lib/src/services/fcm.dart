import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/app.dart';
import 'package:freshfood/src/common/dialog/dialogAnimationWrapper.dart';
import 'package:freshfood/src/helpers/limit_string.dart';
import 'package:freshfood/src/pages/Admin/controller/admin_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

final adminController = Get.put(AdminController());

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

handleReceiveNotification(context) async {
  await requestPermission();
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {

  //   if (message != null) {
  //     if (message.data != null) {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //             ),
  //           );
  //         },
  //         barrierColor: Color(0x80000000),
  //         barrierDismissible: false,
  //       );
  //       Future.delayed(Duration(milliseconds: 1200), () async {
  //         Get.back();
  //         await handleNotificationInApp(message.data);
  //       });
  //     }
  //   }
  // });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.data != null) {
      if (message.data['action'] != 'MESSAGE') {
        if (message.data['action'] == 'NEW_ORDER' ||
            message.data['action'] == 'UPDATE_STATUS_ORDER') {
          //   if (Get.currentRoute == Routes.ADMIN_MANAGER_ORDER) {
          //     // AdminRepository().getLoanById(message.data['_id']).then((value) {
          //       // adminController.insertLoan(value);
          //     // });
          //   } else {
          showDialogFCM(context, message);
          //   }
          // } else {
          //   showDialogFCM(context, message);
        }
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: message.notification.title,
          subTitle: limitString(message.notification.body, 35),
          handlePressed: () {
            if (userProvider.user.role == 0) {
              Get.toNamed(Routes.CHAT_DETAIL, arguments: {
                'id': message.data['idRoom'],
                'name': message.data['name'],
                'image': avatarAdmin
              });
            } else {
              AdminRepository()
                  .getUserById(message.data['idRoom'])
                  .then((value) {
                Get.toNamed(Routes.CHAT_DETAIL, arguments: {
                  'id': message.data['idRoom'],
                  'name': message.data['name'],
                  'image': value['avatar']
                });
              });
            }
          },
        );
        if (Get.currentRoute != Routes.CHAT_DETAIL) {
          getSnackBar.show();
        }
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint(
        'A new onMessageOpenedApp event was published!' + ' lambiengcode');
    showDialogFCM(context, message);
  }).onError((error) => print('Error: $error [\'lambiengcode\']'));
}

showDialogFCM(context, RemoteMessage message) async {
  await dialogAnimationWrapper(
      context: context,
      child: Container(
        width: 300.sp,
        height: 200.sp,
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Text(
                message.notification.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.5.sp),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: message.notification.body,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.sp),
            Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                handleNotificationInApp(message.data);
              },
              child: Container(
                color: Colors.transparent,
                width: 300.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Text(
                  'Kiểm tra ngay',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.transparent,
                width: 300.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Text(
                  'Đã hiểu',
                  style: TextStyle(fontSize: 11.sp),
                ),
              ),
            ),
          ],
        ),
      ));
}

handleNotificationInApp(Map<String, dynamic> data) {
  if (data != null) {
    switch (data['action']) {

      // case 'ACCEPT':
      //   if (Get.currentRoute == Routes.HISTORY) {
      //     Get.offAndToNamed(Routes.HISTORY);
      //   } else {
      //     Get.toNamed(Routes.HISTORY);
      //   }
      //   break;
      // case 'REJECT':
      //   if (Get.currentRoute == Routes.HISTORY) {
      //     Get.offAndToNamed(Routes.HISTORY);
      //   } else {
      //     Get.toNamed(Routes.HISTORY);
      //   }
      //   break;

      case 'NEW_ORDER':
        if (Get.currentRoute == Routes.ADMIN_MANAGER_ORDER) {
          Get.offAndToNamed(Routes.ADMIN_MANAGER_ORDER);
        } else {
          Get.toNamed(Routes.ADMIN_MANAGER_ORDER);
        }
        break;
      case 'UPDATE_STATUS_ORDER':
        if (userProvider.user.role == 0) {
          if (Get.currentRoute == Routes.ORDER) {
            Get.offAndToNamed(Routes.ORDER);
          } else {
            Get.toNamed(Routes.ORDER);
          }
        } else {
          if (Get.currentRoute == Routes.ADMIN_MANAGER_ORDER) {
            Get.offAndToNamed(Routes.ADMIN_MANAGER_ORDER);
          } else {
            Get.toNamed(Routes.ADMIN_MANAGER_ORDER);
          }
        }
        break;
      case 'MESSAGE':
        print('chanquadi');
        // if (Get.currentRoute == Routes.CHAT_DETAIL) {
        //   Get.offAndToNamed(Routes.CHAT_DETAIL, arguments: {
        //     'id': data['idRoom'],
        //     'name': data['name'],
        //   });
        // } else {
        if (Get.currentRoute != Routes.CHAT_DETAIL) {
          if (userProvider.user.role == 0) {
            Get.toNamed(Routes.CHAT_DETAIL, arguments: {
              'id': data['idRoom'],
              'name': data['name'],
              'image': avatarAdmin
            });
          } else {
            AdminRepository().getUserById(data['idRoom']).then((value) {
              Get.toNamed(Routes.CHAT_DETAIL, arguments: {
                'id': data['idRoom'],
                'name': data['name'],
                'image': value['avatar']
              });
            });
          }
        } else {
          if (userProvider.user.role == 0) {
            Get.offAndToNamed(Routes.CHAT_DETAIL, arguments: {
              'id': data['idRoom'],
              'name': data['name'],
              'image': avatarAdmin
            });
          } else {
            AdminRepository().getUserById(data['idRoom']).then((value) {
              Get.offAndToNamed(Routes.CHAT_DETAIL, arguments: {
                'id': data['idRoom'],
                'name': data['name'],
                'image': value['avatar']
              });
            });
          }
        }
        // }
        break;
    }
  }
}

openDetails(dynamic data) {}
