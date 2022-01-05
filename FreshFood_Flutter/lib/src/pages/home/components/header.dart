import 'package:flutter/material.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Header extends StatelessWidget {
  Size size;
  Header(this.size);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      height: size.height * 0.1,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding + 30),
            height: size.height * 0.1 - 27,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
          ),
          Column(
            children: [
              Center(
                  child: Text(Provider.of<UserProvider>(context).user.name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))),
              SizedBox(height: 30.sp)
            ],
          )
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     alignment: Alignment.center,
          //     margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //     height: 54,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //               offset: Offset(0, 10),
          //               blurRadius: 50,
          //               color: kPrimaryColor.withOpacity(0.23))
          //         ]),
          //     // child: Row(
          //     //   children: <Widget>[
          //     //     Expanded(
          //     //       child: TextField(
          //     //         decoration: InputDecoration(
          //     //           hintText: "Search",
          //     //           hintStyle: TextStyle(
          //     //             color: kPrimaryColor.withOpacity(0.5),
          //     //           ),
          //     //           enabledBorder: InputBorder.none,
          //     //           focusedBorder: InputBorder.none,
          //     //         ),
          //     //       ),
          //     //     ),
          //     //     SvgPicture.asset("assets/icons/search.svg"),
          //     //   ],
          //     // ),
          //   ),
          // )
        ],
      ),
    );
  }
}
