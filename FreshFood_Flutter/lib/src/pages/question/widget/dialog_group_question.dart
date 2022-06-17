import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/common/dialog/dialogAnimationWrapper.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/group_question_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

showDialogFCM(context, String title, String id) async {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  await dialogAnimationWrapper(
      context: context,
      child: Container(
        width: 300.sp,
        height: 170.sp,
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            Container(
              width: 70.w,
              child: Material(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: title,
                    validator: (val) => val.trim().length == 0
                        ? 'Vui lòng điền tên bộ câu hỏi'
                        : null,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    onChanged: (val) {
                      title = val.trim();
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      hintText: 'Nhập tên bộ câu hỏi',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      labelText: 'Tên bộ câu hỏi',
                      prefixIcon: Container(
                          child: new Icon(
                        PhosphorIcons.book_open,
                        color: Colors.black,
                      )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.sp),
            Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  if (id.isEmpty) {
                    GroupQuestionRepository()
                        .createGroupQuestion(title)
                        .then((value) {
                      if (value == null) return;
                      Get.back();
                      GetSnackBar getSnackBar = GetSnackBar(
                        title: 'Thêm thành công',
                        subTitle: 'Thêm bộ câu hỏi thành công',
                      );
                      getSnackBar.show();
                      final _groupQuestionController =
                          Get.put(GroupQuestionController());
                      _groupQuestionController.initialController();
                      _groupQuestionController.getGroupQuestion();
                    });
                  } else {
                    GroupQuestionRepository()
                        .updateGroupQuestion(id, title)
                        .then((value) {
                      if (value == null) return;
                      Get.back();
                      GetSnackBar getSnackBar = GetSnackBar(
                        title: 'Sửa thành công',
                        subTitle: 'Sửa bộ câu hỏi thành công',
                      );
                      getSnackBar.show();
                      final _groupQuestionController =
                          Get.put(GroupQuestionController());
                      _groupQuestionController.initialController();
                      _groupQuestionController.getGroupQuestion();
                    });
                  }
                }
              },
              child: Container(
                color: Colors.transparent,
                width: 300.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Text(
                  id.isEmpty ? 'Thêm' : 'Sửa',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
}
