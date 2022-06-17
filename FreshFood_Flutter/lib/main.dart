import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfood/src/app.dart';
import 'package:freshfood/src/lang/translation_service.dart';
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
