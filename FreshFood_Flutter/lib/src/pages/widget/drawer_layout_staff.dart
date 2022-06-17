import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/Admin/manager_product_page.dart';
import 'package:freshfood/src/pages/Admin/manager_user.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:freshfood/src/services/socket_emit.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerLayoutStaff extends StatefulWidget {
  int status;
  DrawerLayoutStaff({this.status});
  @override
  State<StatefulWidget> createState() => _DrawerLayoutStaffState();
}

class _DrawerLayoutStaffState extends State<DrawerLayoutStaff> {
  List<String> listAdmin = [
    "Quản lý đơn hàng",
    "Thông tin cá nhân",
    "Đổi mật khẩu",
    "Đăng xuất"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'http://freshfoods.vn/images/freshfoods.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.ADMIN_MANAGER_ORDER,
                  );
                },
                child: _buildLineDrawer(
                  context,
                  0,
                  PhosphorIcons.fish_bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE,
                      arguments: {'user': userProvider.user});
                },
                child: _buildLineDrawer(
                  context,
                  1,
                  PhosphorIcons.user_bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CHANGE_PASSWORD);
                },
                child: _buildLineDrawer(
                  context,
                  2,
                  PhosphorIcons.lock,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await SocketEmit().deleteDeviceInfo();
                  await FirebaseMessaging.instance.deleteToken();
                  socket.disconnect();
                  userProvider.setUser(null);
                  Get.offAllNamed(Routes.ROOT);
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  _googleSignIn.disconnect();
                },
                child: _buildLineDrawer(
                  context,
                  3,
                  PhosphorIcons.sign_out_bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18.sp, right: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nhân viên',
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontSize: 8.5.sp,
                    // fontFamily: FontFamily.lato,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLineDrawer(context, title, icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.25.sp, horizontal: 10.sp),
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(
            icon,
            color: title == widget.status ? kPrimaryColor : colorTitle,
            size: 17.25.sp,
          ),
          SizedBox(width: 10.sp),
          Text(
            listAdmin[title],
            style: TextStyle(
              color: title == widget.status ? kPrimaryColor : colorTitle,
              fontSize: 11.25.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
