import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function tap;
  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        height: 10.w * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: 10.w * 4,
        ).copyWith(
          bottom: 10.w * 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w * 3),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
              .90,
              .0,
            ), // 10% of the width, so there are ten blinds.
            colors: [
              Colors.green.shade50,
              Colors.white,
            ], // red to yellow
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 10.w * 2.5,
            ),
            SizedBox(width: 10.w * 1.5),
            Text(
              this.text,
              // style: kTitleTextStyle.copyWith(
              //   fontWeight: FontWeight.w500,
              // ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: 10.w * 2.5,
              ),
          ],
        ),
      ),
    );
  }
}
