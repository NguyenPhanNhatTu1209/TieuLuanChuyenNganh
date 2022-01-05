import 'package:freshfood/src/pages/Admin/manager_product_page.dart';
import 'package:freshfood/src/pages/Admin/manager_user.dart';
import 'package:freshfood/src/pages/authentication/authentication_page.dart';
import 'package:freshfood/src/pages/cart/cart_page.dart';
import 'package:freshfood/src/pages/home/home_page.dart';
import 'package:freshfood/src/pages/navigation/navigation.dart';
import 'package:freshfood/src/pages/order/order_page_admin.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

String avatarAdmin = '';

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    AdminRepository().getAvatar().then((value) {
      avatarAdmin = value['avatar'];
      print(avatarAdmin);
    });
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<UserProvider>(context, listen: false).checkLogined();
      setState(() {});
    });
  }
  // Provider.of<UserProvider>(context, listen: false).checkLogined();
  // setState(() {});

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).user != null
        ? Provider.of<UserProvider>(context).user.role == 0
            ? Navigation()
            : Provider.of<UserProvider>(context).user.role == 1
                ? ManagerProductPage()
                : OrderPageAdmin()
        : AuthenticationPages();
  }
}
