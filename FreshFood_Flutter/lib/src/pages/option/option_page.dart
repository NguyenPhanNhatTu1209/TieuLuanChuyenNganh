import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/option/widgets/profile_list_item.dart';
import 'package:freshfood/src/pages/products/controllers/product_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:freshfood/src/services/socket_emit.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controllers/profile_controller.dart';

class OptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        height: 100.h, width: 100.w, allowFontScaling: true);

    var profileInfo = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 30.w,
            width: 30.w,
            // margin: EdgeInsets.only(top: 10.w * 3),
            child: Stack(
              children: <Widget>[
                // GetBuilder<ProfileController>(
                //     init: profileController,
                //     builder: (_) => _.user.avatar != null
                //         ? CircleAvatar(
                //             radius: 10.w * 3,
                //             backgroundImage: NetworkImage(_.user.avatar),
                //             backgroundColor: Colors.transparent,
                //           )
                //         : CircleAvatar(
                //             radius: 10.w * 3,
                //             backgroundImage:
                //                 AssetImage('assets/images/avatar.png'),
                //             backgroundColor: Colors.transparent,
                //           )),
                CircleAvatar(
                  radius: 10.w * 3,
                  backgroundImage: NetworkImage(
                      Provider.of<UserProvider>(context).user.avatar),
                  backgroundColor: Colors.transparent,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     height: 10.w ,
                //     width: 10.w * 2.5,
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).accentColor,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Center(
                //       heightFactor: 10.w * 1.5,
                //       widthFactor: 10.w * 1.5,
                //       child: Icon(
                //         LineAwesomeIcons.pen,
                //         color: kDarkPrimaryColor,
                //         size: ScreenUtil().setSp(10.w * 1.5),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 5.w),
          // GetBuilder<ProfileController>(
          //   init: profileController,
          //   builder: (_) => _.user.name != null
          //       ? Text(
          //           _.user.name,
          //           style: kTitleTextStyle,
          //         )
          //       : Text(
          //           "",
          //           style: kCaptionTextStyle,
          //         ),
          // ),
          Text(
            Provider.of<UserProvider>(context).user.name,
            style: kTitleTextStyle,
          ),
          SizedBox(height: 3.w),
          Text(
            Provider.of<UserProvider>(context).user.email,
            style: kCaptionTextStyle,
          ),

          SizedBox(height: 10.w),
          // Container(
          //   height: 10.w * 4,
          //   width: 10.w * 20,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10.w * 3),
          //     color: Theme.of(context).accentColor,
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Upgrade to PRO',
          //       style: kButtonTextStyle,
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 10.w * 3),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: ScreenUtil().setSp(10.w * 3),
        ),
        // profileInfo,
        SizedBox(width: 10.w * 3),
      ],
    );

    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: 20.w),
            profileInfo,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ProfileListItem(
                      icon: LineAwesomeIcons.user_shield,
                      text: 'Thông tin cá nhân',
                      tap: () {
                        Get.toNamed(Routes.PROFILE,
                            arguments: {"user": userProvider.user});
                      },
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.history,
                      text: 'Xem tất cả đơn',
                      tap: () {
                        Get.toNamed(Routes.ORDER);
                      },
                    ),

                    ProfileListItem(
                      icon: LineAwesomeIcons.lock,
                      text: 'Đổi mật khẩu',
                      tap: () {
                        Get.toNamed(Routes.CHANGE_PASSWORD);
                      },
                    ),
                    // ProfileListItem(
                    //   icon: LineAwesomeIcons.user_plus,
                    //   text: 'Invite a Friend',
                    // ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.alternate_sign_out,
                      text: 'Đăng xuất',
                      hasNavigation: false,
                      tap: () async {
                        await SocketEmit().deleteDeviceInfo();
                        await FirebaseMessaging.instance.deleteToken();
                        socket.disconnect();
                        userProvider.setUser(null);
                        Get.offAllNamed(Routes.ROOT);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
