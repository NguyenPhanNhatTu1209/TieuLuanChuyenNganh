import 'package:flutter/material.dart';

Future dialogAnimationWrapper(
    {context,
    slideFrom = 'left',
    child,
    duration = 320,
    paddingTop = 0.0,
    paddingBottom = 0.0,
    backgroundColor = Colors.white,
    paddingHorizontal = 15.0,
    dismissible = true,
    borderRadius = 25.0,
    barrierColor,
    maxWidth = 320.0}) {
  var beginOffset = Offset(-1, 0);
  switch (slideFrom) {
    case 'left':
      beginOffset = Offset(-1, 0);
      break;
    case 'right':
      beginOffset = Offset(1, 0);
      break;
    case 'top':
      beginOffset = Offset(0, -1);
      break;
    case 'bottom':
      beginOffset = Offset(0, 1);
      break;
  }
  return showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: dismissible,
    barrierColor:
        barrierColor != null ? barrierColor : Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: duration),
    context: context,
    pageBuilder: (_, __, ___) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        insetPadding: EdgeInsets.only(
            left: paddingHorizontal,
            right: paddingHorizontal,
            top: paddingTop,
            bottom: paddingBottom),
        child: Container(
          constraints: BoxConstraints(maxWidth: 320),
          child: child,
        ),
        backgroundColor: backgroundColor,
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: beginOffset, end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
