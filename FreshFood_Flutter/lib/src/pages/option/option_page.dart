import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/answer/controllers/answer_controller.dart';
import 'package:freshfood/src/pages/option/widgets/profile_list_item.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:freshfood/src/services/socket_emit.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controllers/profile_controller.dart';

class OptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  final _profileController = Get.put(ProfileController());
  final _answerController = Get.put(AnswerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _answerController.initController();
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
          SizedBox(height: 2.w),
          Text(
            Provider.of<UserProvider>(context).user.email,
            style: kCaptionTextStyle,
          ),
          Row(
            children: [
              SizedBox(width: 25.w),
              Container(
                margin: EdgeInsets.only(left: 20.sp),
                child: Image(
                  image: AssetImage('images/icon-money.png'),
                  height: 7.h,
                  width: 7.h,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.sp, right: 10.sp),
                width: 20.w,
                child: Text(
                  Provider.of<UserProvider>(context).user.point != null
                      ? "${Provider.of<UserProvider>(context).user.point.toString()} xu"
                      : "0 xu",
                  style: TextStyle(fontSize: 14.sp, color: Colors.green),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 5.w),
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
                    ProfileListItem(
                      icon: LineAwesomeIcons.book_open,
                      text: 'Câu hỏi kiếm xu',
                      tap: () {
                        _answerController.getAllQuestion();
                      },
                    ),
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
                        GoogleSignIn _googleSignIn = GoogleSignIn();
                        _googleSignIn.disconnect();
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
