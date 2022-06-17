import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/pages/products/controllers/group_product_controller.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class EditQuestionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productController = Get.put(ProductController());
  ScrollController scrollController = ScrollController();
  var priceTest = MoneyMaskedTextController(
      decimalSeparator: '',
      thousandSeparator: '.',
      leftSymbol: 'đ',
      precision: 0); //after

  List<File> _image = [];
  ImagePicker _imagePicker = ImagePicker();
  List<dynamic> test = [];
  StreamController<List<dynamic>> _listImage =
      StreamController<List<dynamic>>.broadcast();
  //
  int time;
  String name;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  bool isCorrectA = false;
  bool isCorrectB = false;
  bool isCorrectC = false;
  bool isCorrectD = false;

  //
  String grProduct;
  final _groupProduct = Get.put(GroupProductController());
  @override
  initState() {
    super.initState();

    _groupProduct.initialController();
    _groupProduct.getGroupProduct();
  }

  Widget _buildAction(context, title, icon) {
    final _size = MediaQuery.of(context).size;
    Future<void> _pickImage(ImageSource source) async {
      List<XFile> listSelectedSource = await _imagePicker.pickMultiImage(
        imageQuality: 80,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (listSelectedSource.isNotEmpty) {
        setState(() {
          _image = listSelectedSource.map((item) => File(item.path)).toList();
          _listImage.add(_image);
        });
        Get.back();
      }
    }

    return GestureDetector(
      onTap: () {
        switch (title) {
          // English
          case 'Take a Photo':
            _pickImage(ImageSource.camera);
            break;
          case 'Choose from Album':
            _pickImage(ImageSource.gallery);
            break;

          // Vietnamese
          case 'Chụp ảnh':
            _pickImage(ImageSource.camera);
            break;
          case 'Chọn ảnh từ Album':
            _pickImage(ImageSource.gallery);
            break;

          default:
            break;
        }
      },
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 16.0,
                  color: Colors.grey.shade800,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 22.5,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
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
            "Chỉnh sửa Câu hỏi",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => {},
              icon: Icon(
                PhosphorIcons.trash,
                color: Colors.white,
                size: 7.w,
              ),
            )
          ],
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
                      "name",
                      'Điền chi tiết câu hỏi',
                      'Tiêu đề câu hỏi',
                      PhosphorIcons.question,
                      false,
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
                        null,
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
                        null,
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
                        null,
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
                        null,
                        isCorrectD),
                    SizedBox(
                      height: 30.0,
                    ),
                    BuildTextField(
                        'Vui lòng điền thời gian trả lời câu hỏi!',
                        "time",
                        'Điền thời gian trả lời',
                        'Thời gian',
                        PhosphorIcons.timer,
                        null,
                        true),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
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
                          }
                        },
                        child: Text(
                          'Lưu Câu hỏi',
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
        onChanged: (val) {
          setState(() {
            if (type == "name")
              name = val.trim();
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
