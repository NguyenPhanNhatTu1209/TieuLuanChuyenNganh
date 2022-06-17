import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/group_question_model.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'dialog_group_question.dart';

class GroupQuestionItem extends StatefulWidget {
  GroupQuestionModel groupQuestion;
  int index;
  GroupQuestionItem({this.groupQuestion, this.index});
  @override
  State<StatefulWidget> createState() {
    return _GroupQuestiontItemState();
  }
}

class _GroupQuestiontItemState extends State<GroupQuestionItem> {
  bool isMain = false;
  final _groupQuestionController = Get.put(GroupQuestionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.MANAGER_QUESTION,
            arguments: {"idGroup": widget.groupQuestion.id});
      },
      splashColor: Colors.grey,
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProductImage(
                'https://static.helpjuice.com/helpjuice_production/uploads/upload/image/4752/direct/1597678311691-Explicit%20Knowledge.jpg',
                height: 30.w,
                width: 30.w,
                padding: 3.w,
              ),
              // SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          widget.groupQuestion.title,
                          style: TextStyle(
                            fontSize: 5.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialogFCM(
                              context,
                              widget.groupQuestion.title,
                              widget.groupQuestion.id,
                            );
                          },
                          icon: Icon(
                            PhosphorIcons.pen,
                            size: 5.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.w),
                    Row(
                      children: [
                        Text(
                          'Số câu hỏi: ' +
                              widget.groupQuestion.numberQuestion.toString(),
                          style: TextStyle(
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 35.w),
                      child: CupertinoSwitch(
                        value: widget.groupQuestion.isActive,
                        onChanged: (value) {
                          if (value &&
                              widget.groupQuestion.numberQuestion == 0) {
                            GetSnackBar getSnackBar = GetSnackBar(
                              title: 'Vui lòng thêm câu hỏi trước',
                              subTitle:
                                  'Không thể mở bộ câu hỏi khi chưa có câu nào',
                            );
                            getSnackBar.show();
                            return;
                          }
                          _groupQuestionController.changeStatus(
                              widget.index, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey)
        ]),
      ),
    );
  }
}
