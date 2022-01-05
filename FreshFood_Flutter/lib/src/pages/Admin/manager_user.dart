import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/Admin/controller/admin_controller.dart';
import 'package:freshfood/src/pages/Admin/manager_user_detail.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManagerUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManagerUserState();
}

class _ManagerUserState extends State<ManagerUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final adminController = Get.put(AdminController());
  ScrollController scrollController = ScrollController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    adminController.initialController();
    adminController.getAllUser(search: '');
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          adminController.getAllUser(search: _search);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Container(
          width: 70.w,
          child: Drawer(
            child: DrawerLayoutAdmin(status: 1),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Text(
            "Quản Lý người dùng",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.sp, left: 5.sp, right: 5.sp),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    _search = value;
                    adminController.initialController();
                    adminController.getAllUser(
                      search: _search,
                    );
                  }),
            ),
            Expanded(
              child: GetBuilder<AdminController>(
                init: adminController,
                builder: (_) => ListView.builder(
                  padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
                  controller: scrollController,
                  itemCount: adminController.listUser.length,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      SizedBox(height: 60.sp),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            adminController.listUser[index].avatar),
                      ),
                      SizedBox(width: 10.sp),
                      Container(
                        child: Text(
                          _.listUser[index].name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        width: 100.sp,
                      ),
                      SizedBox(width: 30.sp),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_INFORMATION_USER,
                              arguments: {
                                "user": adminController.listUser[index]
                              });
                        },
                        splashColor: Colors.grey,
                        child: Icon(
                          PhosphorIcons.notepad,
                          size: 25.sp,
                        ),
                      ),
                      SizedBox(width: 30.sp),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.STATISTIC_USER, arguments: {
                            "id": adminController.listUser[index].id
                          });
                        },
                        splashColor: Colors.grey,
                        child: Icon(
                          PhosphorIcons.chart_line,
                          size: 25.sp,
                        ),
                      )
                    ]);
                  },
                ),
              ),
              // ListView.builder(
              //   padding: EdgeInsets.all(20),
              //   itemCount: listCustomer.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Row(children: [
              //       SizedBox(height: 60.sp),
              //       CircleAvatar(
              //         radius: 20,
              //         backgroundImage: NetworkImage(listCustomer[index].avatar),
              //       ),
              //       SizedBox(width: 10.sp),
              //       Container(
              //         child: Text(
              //           listCustomer[index].email,
              //           style: TextStyle(
              //             fontSize: 17.sp,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //         ),
              //         width: 100.sp,
              //       ),
              //       SizedBox(width: 30.sp),
              //       Icon(
              //         PhosphorIcons.notepad,
              //         size: 25.sp,
              //       ),
              //       SizedBox(width: 30.sp),
              //       Icon(
              //         PhosphorIcons.chart_line,
              //         size: 25.sp,
              //       )
              //     ]);
              //   },
              // ),
            ),
          ],
        ));
  }
}
