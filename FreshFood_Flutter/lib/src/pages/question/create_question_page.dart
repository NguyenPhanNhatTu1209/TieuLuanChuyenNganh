import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/pages/products/controllers/group_product_controller.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/pages/question/controllers/question_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/question_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controllers/group_question_controller.dart';

class CreateQuestionPage extends StatefulWidget {
  String idGroup;
  dynamic question;
  CreateQuestionPage({this.idGroup, this.question});
  @override
  State<StatefulWidget> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productController = Get.put(ProductController());
  ScrollController scrollController = ScrollController();
  TextEditingController _timeController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _answerAController = new TextEditingController();
  TextEditingController _answerBController = new TextEditingController();
  TextEditingController _answerCController = new TextEditingController();
  TextEditingController _answerDController = new TextEditingController();
  final _groupQuestionController = Get.put(GroupQuestionController());
  final _questionController = Get.put(QuestionController());

  int time;
  String title;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  bool isCorrectA = false;
  bool isCorrectB = false;
  bool isCorrectC = false;
  bool isCorrectD = false;

  @override
  initState() {
    super.initState();
    if (widget.question != null) {
      _timeController.text = widget.question['time'].toString();
      _titleController.text = widget.question['title'];
      _answerAController.text = widget.question['answerA'];
      _answerBController.text = widget.question['answerB'];
      _answerCController.text = widget.question['answerC'];
      _answerDController.text = widget.question['answerD'];
      isCorrectA = widget.question['isTrueA'];
      isCorrectB = widget.question['isTrueB'];
      isCorrectC = widget.question['isTrueC'];
      isCorrectD = widget.question['isTrueD'];
    }
  }

  Future<void> updateListQuestion() {
    _groupQuestionController.initialController();
    _groupQuestionController.getGroupQuestion();

    _questionController.initialController();
    _questionController.getAllQuestionByGroup(widget.idGroup);
  }

  Future<void> createQuestion() async {
    QuestionRepository()
        .createQuestion(
      time: time,
      groupQuestion: widget.idGroup,
      title: title,
      answerA: answerA,
      answerB: answerB,
      answerC: answerC,
      answerD: answerD,
      isCorrectA: isCorrectA,
      isCorrectB: isCorrectB,
      isCorrectC: isCorrectC,
      isCorrectD: isCorrectD,
    )
        .then((value) {
      Get.back();
      if (value == null) {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Tạo thất bại',
          subTitle: 'Vui lòng kiểm tra đủ các trường',
        );
        getSnackBar.show();
      } else {
        updateListQuestion();
        Get.back();
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Tạo thành công',
          subTitle: 'Tạo thành công câu hỏi',
        );
        getSnackBar.show();
      }
    });
  }

  Future<void> updateQuestion() async {
    QuestionRepository()
        .updateQuestion(
      id: widget.question['_id'],
      time: int.parse(_timeController.text),
      groupQuestion: widget.idGroup,
      title: _titleController.text,
      answerA: _answerAController.text,
      answerB: _answerBController.text,
      answerC: _answerCController.text,
      answerD: _answerDController.text,
      isCorrectA: isCorrectA,
      isCorrectB: isCorrectB,
      isCorrectC: isCorrectC,
      isCorrectD: isCorrectD,
    )
        .then((value) {
      Get.back();
      if (value == null) {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Cập nhật thất bại',
          subTitle: 'Vui lòng kiểm tra đủ các trường',
        );
        getSnackBar.show();
      } else {
        updateListQuestion();
        Get.back();
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Cập nhật thành công',
          subTitle: 'Cập nhật thành công câu hỏi',
        );
        getSnackBar.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Container(
          width: 70.w,
          child: Drawer(
            child: DrawerLayout(),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              PhosphorIcons.arrow_left,
              color: Colors.white,
              size: 7.w,
            ),
          ),
          title: Text(
            "Tạo Câu hỏi",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: 100.h,
            width: 100.w,
            child: ListView(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextField(
                      'Vui lòng điền tiêu đề câu hỏi!',
                      "title",
                      'Điền chi tiết câu hỏi',
                      'Tiêu đề câu hỏi',
                      PhosphorIcons.question,
                      _titleController,
                      false,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextFieldCheckBox(
                        'Vui lòng điền đáp án câu A!',
                        "answerA",
                        'Điền đáp án của câu A',
                        'Đáp án A',
                        PhosphorIcons.book_open,
                        _answerAController,
                        isCorrectA),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextFieldCheckBox(
                        'Vui lòng điền đáp án câu B!',
                        "answerB",
                        'Điền đáp án của câu B',
                        'Đáp án B',
                        PhosphorIcons.book_open,
                        _answerBController,
                        isCorrectB),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextFieldCheckBox(
                        'Vui lòng điền đáp án câu C!',
                        "answerC",
                        'Điền đáp án của câu C',
                        'Đáp án C',
                        PhosphorIcons.book_open,
                        _answerCController,
                        isCorrectC),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextFieldCheckBox(
                        'Vui lòng điền đáp án câu D!',
                        "answerD",
                        'Điền đáp án của câu D',
                        'Đáp án D',
                        PhosphorIcons.book_open,
                        _answerDController,
                        isCorrectD),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextField(
                        'Vui lòng điền thời gian trả lời câu hỏi!',
                        "time",
                        'Điền thời gian trả lời',
                        'Thời gian (giây)',
                        PhosphorIcons.timer,
                        _timeController,
                        true),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (!isCorrectA &&
                                !isCorrectB &&
                                !isCorrectC &&
                                !isCorrectD) {
                              GetSnackBar getSnackBar = GetSnackBar(
                                title: 'Tạo câu hỏi thất bại',
                                subTitle: 'Vui lòng chọn đáp án đúng',
                              );
                              getSnackBar.show();
                              return;
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  );
                                },
                                barrierColor: Color(0x80000000),
                                barrierDismissible: false);
                            widget.question == null
                                ? createQuestion()
                                : updateQuestion();
                          }
                        },
                        child: Text(
                          widget.question == null ? 'Tạo Câu hỏi' : 'Sửa',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Material BuildTextField(
    String vali,
    dynamic type,
    String placeholder,
    String lable_text,
    IconData iconData,
    name_controller,
    bool number,
  ) {
    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryColor.withOpacity(0.38),
      child: TextFormField(
        controller: name_controller == false ? null : name_controller,
        validator: (val) => val.trim().length == 0 ? vali : null,
        inputFormatters: [
          type != 'title'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        onChanged: (val) {
          setState(() {
            if (type == "title")
              title = val.trim();
            else if (type == "time") time = int.tryParse(val.trim());
          });
        },
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        keyboardType: number ? TextInputType.number : null,
        decoration: InputDecoration(
          fillColor: Colors.black,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          labelText: lable_text,
          prefixIcon: Container(
              child: new Icon(
            iconData,
            color: Colors.black,
          )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Material BuildTextFieldCheckBox(String vali, dynamic type, String placeholder,
      String lable_text, IconData iconData, name_controller, bool isCorrect) {
    final _size = MediaQuery.of(context).size;

    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryColor.withOpacity(0.38),
      child: Row(children: [
        Expanded(
          flex: 6,
          child: TextFormField(
            controller: name_controller == false ? null : name_controller,
            validator: (val) => val.trim().length == 0 ? vali : null,
            onChanged: (val) {
              setState(() {
                if (type == "answerA")
                  answerA = val.trim();
                else if (type == "answerB")
                  answerB = val.trim();
                else if (type == "answerC")
                  answerC = val.trim();
                else if (type == "answerD") answerD = val.trim();
              });
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              fillColor: Colors.black,
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
              labelText: lable_text,
              prefixIcon: Container(
                  child: new Icon(
                iconData,
                color: Colors.black,
              )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              child: isCorrect
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (type == 'answerA') {
                            isCorrectA = false;
                            isCorrect = false;
                          } else if (type == 'answerB') {
                            isCorrectB = false;
                            isCorrect = false;
                          } else if (type == 'answerC') {
                            isCorrectC = false;
                            isCorrect = false;
                          } else if (type == 'answerD') {
                            isCorrectD = false;
                            isCorrect = false;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6.sp),
                        child: Icon(
                          PhosphorIcons.check_circle,
                          size: _size.width / 6.5,
                          color: Colors.green,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          if (type == 'answerA') {
                            isCorrectA = true;
                            isCorrect = true;
                          } else if (type == 'answerB') {
                            isCorrectB = true;
                            isCorrect = true;
                          } else if (type == 'answerC') {
                            isCorrectC = true;
                            isCorrect = true;
                          } else if (type == 'answerD') {
                            isCorrectD = true;
                            isCorrect = true;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6.sp),
                        child: Icon(
                          PhosphorIcons.circle,
                          size: _size.width / 6.5,
                          color: Colors.green,
                        ),
                      ),
                    )),
        )
      ]),
    );
  }
}
