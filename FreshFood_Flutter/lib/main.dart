import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfood/src/app.dart';
import 'package:freshfood/src/lang/translation_service.dart';
import 'package:freshfood/src/pages/Admin/edit_product_page.dart';
import 'package:freshfood/src/pages/Admin/manager_product_page.dart';
import 'package:freshfood/src/pages/Admin/manager_user.dart';
import 'package:freshfood/src/pages/Admin/statistic_page.dart';
import 'package:freshfood/src/pages/Admin/statistic_user.dart';
import 'package:freshfood/src/pages/address/address_page.dart';
import 'package:freshfood/src/pages/address/edit_address_page.dart';
import 'package:freshfood/src/pages/address/update_address_page.dart';
import 'package:freshfood/src/pages/authentication/authentication_page.dart';
import 'package:freshfood/src/pages/authentication/change_password_with_otp_page.dart';
import 'package:freshfood/src/pages/authentication/fogot_password_page.dart';
import 'package:freshfood/src/pages/authentication/otp_password_page.dart';
import 'package:freshfood/src/pages/eveluate/eveluate_page.dart';
import 'package:freshfood/src/pages/eveluate/eveluate_product_page.dart';
import 'package:freshfood/src/pages/order/order_detail_page.dart';
import 'package:freshfood/src/pages/order/order_history_page.dart';
import 'package:freshfood/src/pages/order/order_page.dart';
import 'package:freshfood/src/pages/order/order_page_admin.dart';
import 'package:freshfood/src/pages/payment/payment_detail.dart';
import 'package:freshfood/src/pages/payment/payment_error.dart';
import 'package:freshfood/src/pages/payment/payment_page.dart';
import 'package:freshfood/src/pages/payment/payment_success.dart';
import 'package:freshfood/src/pages/products/create_product_screen.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/shared/logger/logger_utils.dart';
import 'package:freshfood/src/theme/theme_service.dart';
import 'package:freshfood/src/theme/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await GetStorage.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (context) => userProvider,
      ),
      // ChangeNotifierProvider<AddressProvider>(
      //   create: (context) => addressProvider,
      // ),
      // ChangeNotifierProvider<ChatProvider>(
      //   create: (context) => chatProvider,
      // ),
      // ChangeNotifierProvider<QuantityProvider>(
      //   create: (context) => quantityProvider,
      // ),
      // ChangeNotifierProvider<InfoUserProvider>(
      //   create: (context) => infoUserProvider,
      // ),
    ],
    child: Sizer(builder: (context, orientation, builder) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        logWriterCallback: Logger.write,
        // initialRoute: AppPages.INITIAL,
        home: App(),
        getPages: AppPages.routes,
        // initialRoute: AppPages.INITIAL,
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        themeMode: ThemeService().getThemeMode(),
      );
    }),
  ));
}
