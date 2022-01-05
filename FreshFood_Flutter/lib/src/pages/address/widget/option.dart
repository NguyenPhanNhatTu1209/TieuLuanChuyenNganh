import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:sizer/sizer.dart';

class Option extends StatelessWidget {
  final Function handlePress;
  final String name, description;
  final bool isShowIconArrow;

  Option(
      {this.handlePress,
      this.name = '',
      this.description = '',
      this.isShowIconArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handlePress,
      child: Container(
        padding: EdgeInsets.only(left: 10.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.sp))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 6.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 80.w,
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                isShowIconArrow
                    ? Icon(
                        PhosphorIcons.caret_right,
                        color: Colors.grey,
                        size: 18.sp,
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
