import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/answer/controllers/answer_controller.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/products/controllers/product_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

Future<void> bottomSheetAnswer(
    BuildContext context, String text, Function onpress) {
  final answerController = Get.put(AnswerController());

  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Container(
          // decoration: new BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: new BorderRadius.only(
          //         topLeft: const Radius.circular(10.0),
          //         topRight: const Radius.circular(10.0))),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 5.w,
              ),
              Container(
                child: ClipRRect(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  child: Image.network(
                    answerController.statusAnswer == 1
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShQdIbFqXkmTnpuNJUMemyRiLyJP0Hpt8V6A&usqp=CAU'
                        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY9yK6BOxKik9ZD5mKPlvpVlhDMJG8ApqzbQ&usqp=CAU',
                    fit: BoxFit.fill,
                    height: 43.2.w,
                    width: 50.w,
                  ),
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              Container(
                child: Text(
                  answerController.readStatus(),
                  style: TextStyle(
                    fontSize: 5.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 1.w,
              ),
              Container(
                // padding: EdgeInsets.all(2.w),
                width: 90.w,
                margin: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  border: Border.all(width: 3.w, color: kPrimaryColor),
                  // borderRadius: BorderRadius.circular(20)),
                ),
                child: InkWell(
                  splashColor: kPrimaryColor,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 6.w,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ).whenComplete(() {
    if (answerController.indexQuestion != answerController.listQuestion.length)
      answerController.nextQuestion();
    else {
      Get.back();
      GetSnackBar getSnackBar = GetSnackBar(
        title: 'Hoàn thành bộ câu hỏi',
        subTitle: '',
      );
      getSnackBar.show();
    }
  });
}
