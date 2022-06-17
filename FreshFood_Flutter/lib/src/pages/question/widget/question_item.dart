import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/question/controllers/question_controller.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class QuestionItem extends StatefulWidget {
  dynamic question;
  int index;
  QuestionItem({this.question, this.index});
  @override
  State<StatefulWidget> createState() {
    return _QuestiontItemState();
  }
}

class _QuestiontItemState extends State<QuestionItem> {
  final _questionController = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.green,
          width: 3,
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.black,
          textStyle: const TextStyle(fontSize: 15),
        ),
        onPressed: () {
          Get.toNamed(Routes.CREATE_QUESTION, arguments: {
            'idGroup': widget.question['groupQuestion'],
            'question': widget.question
          });
        },
        child: Text(widget.question['title'],
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
