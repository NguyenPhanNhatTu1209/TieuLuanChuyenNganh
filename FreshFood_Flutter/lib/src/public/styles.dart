import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:sizer/sizer.dart';

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

var colorBlack = Color(0xFF14171A);
var colorDarkGrey = Color(0xFF657786);
var colorPrimary = Color(0xFF1DA1F2);
var colorTitle = Color(0xFF2C3D50);

var colorHigh = Colors.redAccent;
var colorMedium = Colors.amber.shade700;
var colorLow = colorPrimary;
var colorCompleted = Colors.green;
var colorFailed = colorDarkGrey;
var colorActive = Color(0xFF00D72F);
var colorSelected = Color.fromRGBO(0, 128, 128, 1);
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

final kTitleTextStyle = TextStyle(
  fontSize: 5.w,
  fontWeight: FontWeight.w600,
);
final kCaptionTextStyle = TextStyle(
  fontSize: 4.w,
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  // fontSize: ScreenUtil().setSp(10.w),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);

const kDefaultPadding = 20.0;
Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCM = Colors.grey.shade200;
Color mCH = Colors.grey.shade400;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

BoxDecoration nMbox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: mC,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    BoxShadow(
      color: mCL,
      offset: Offset(-10, -10),
      blurRadius: 10,
    ),
  ],
);

BoxDecoration nMboxCategoryOff = BoxDecoration(
  shape: BoxShape.circle,
  color: mC,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    BoxShadow(
      color: mCL,
      offset: Offset(-10, -10),
      blurRadius: 10,
    ),
  ],
);

BoxDecoration nMboxCategoryOn = BoxDecoration(
  shape: BoxShape.circle,
  color: mCD,
  boxShadow: [
    BoxShadow(
        color: mCL, offset: Offset(3, 3), blurRadius: 3, spreadRadius: -3),
  ],
);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: mCD,
    boxShadow: [
      BoxShadow(
          color: mCL, offset: Offset(3, 3), blurRadius: 3, spreadRadius: -3),
    ]);

BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: mCC);

BoxDecoration nMbtn = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: mC,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(2, 2),
      blurRadius: 2,
    )
  ],
);
