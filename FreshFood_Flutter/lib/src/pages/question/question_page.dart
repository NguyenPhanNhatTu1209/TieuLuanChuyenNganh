import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/group_question_model.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:freshfood/src/pages/question/widget/question_item.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'controllers/question_controller.dart';

class QuestionPage extends StatefulWidget {
  String idGroup;
  QuestionPage({this.idGroup});
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _groupQuestion = Get.put(GroupQuestionController());
  final _questionController = Get.put(QuestionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionController.initialController();
    _questionController.getAllQuestionByGroup(widget.idGroup);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: .0,
        backgroundColor: Colors.green.shade50,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            PhosphorIcons.arrow_left,
            color: Color(0xFF2C3D50),
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'Danh sách câu hỏi',
          style: TextStyle(
            color: Color(0xFF2C3D50),
            fontSize: _size.width / 20.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetBuilder<QuestionController>(
        builder: (_) => Container(
          height: _size.height,
          width: _size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(
                .95,
                .0,
              ), // 10% of the width, so there are ten blinds.
              colors: [
                Colors.green.shade50,
                Colors.white,
              ], // red to yellow
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.all(3),
            height: 10.h,
            width: 18.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent)),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/quizz.png'),
                  height: 30.h,
                  fit: BoxFit.fill,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.sp, bottom: 3.sp),
                      child: Text(
                        "Tổng số câu hỏi: ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7.sp, right: 10.sp),
                      width: 20.w,
                      child: Text(
                        _.listQuestion.length.toString(),
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 23.w, top: 4.sp),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.CREATE_QUESTION,
                              arguments: {'idGroup': widget.idGroup});
                        },
                        icon: Icon(
                          PhosphorIcons.plus_circle,
                          color: Color(0xFF2C3D50),
                          size: _size.width / 12,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _.listQuestion.length,
                      itemBuilder: (context, index) {
                        return QuestionItem(
                          question: _.listQuestion[index],
                          index: index,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
