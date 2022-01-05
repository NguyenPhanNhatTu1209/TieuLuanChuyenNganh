import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/app.dart';
import 'package:freshfood/src/pages/cart/cart_page.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/chat/chat_detail_page.dart';
import 'package:freshfood/src/pages/chat/chat_page.dart';
import 'package:freshfood/src/pages/home/home_page.dart';
import 'package:freshfood/src/pages/option/controllers/profile_controller.dart';
import 'package:freshfood/src/pages/option/option_page.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:freshfood/src/services/fcm.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.initialController();
    cartController.getListProduct();
    handleReceiveNotification(context);
    connectAndListen();
  }

  var pages = [
    HomePage(),
    CartPage(),
    ChatDetailScreen(
      id: userProvider.user.id,
      name: "Fresh Food",
      image: avatarAdmin,
    ),
    OptionPage(),
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: kDefaultPadding * 2,
          right: kDefaultPadding * 2,
        ),
        height: 60,
        decoration: selected != 1
            ? BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: Offset(0, -10),
                  blurRadius: 35,
                  color: kPrimaryColor.withOpacity(0.38),
                )
              ])
            : BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavigationItem(
              PhosphorIcons.storefront_fill,
              PhosphorIcons.storefront,
              0,
            ),
            _buildNavigationItem(
              PhosphorIcons.shopping_cart_fill,
              PhosphorIcons.shopping_cart,
              1,
            ),
            _buildNavigationItem(
              PhosphorIcons.messenger_logo_fill,
              PhosphorIcons.messenger_logo,
              2,
            ),
            _buildNavigationItem(
              PhosphorIcons.user_circle_fill,
              PhosphorIcons.user_circle,
              3,
            ),
          ],
        ),
      ),
      body: pages[selected],
    );
  }

  Widget _buildNavigationItem(iconActive, iconInactive, index) {
    return index != 1
        ? IconButton(
            onPressed: () => {
              setState(() {
                selected = index;
              }),
              // if (index == 3) {Get.toNamed(Routes.PROFILE)}
            },
            icon: Icon(
              selected == index ? iconActive : iconInactive,
              size: 20.sp,
              color: selected == index ? kPrimaryColor : Colors.grey.shade600,
            ),
          )
        : Badge(
            position: BadgePosition.topEnd(top: 0, end: 3),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            borderSide: BorderSide(color: Colors.white),
            badgeColor: kPrimaryColor,
            badgeContent: GetBuilder<CartController>(
                init: cartController,
                builder: (_) => _.totalQuantity == null
                    ? Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 2.5.w),
                      )
                    : Text(
                        _.totalQuantity,
                        style: TextStyle(color: Colors.white, fontSize: 2.5.w),
                      )),
            child: IconButton(
              onPressed: () => {
                setState(() {
                  selected = index;
                }),
                // if (index == 3) {Get.toNamed(Routes.PROFILE)}
              },
              icon: Icon(
                selected == index ? iconActive : iconInactive,
                size: 20.sp,
                color: selected == index ? kPrimaryColor : Colors.grey.shade600,
              ),
            ));
  }
}
