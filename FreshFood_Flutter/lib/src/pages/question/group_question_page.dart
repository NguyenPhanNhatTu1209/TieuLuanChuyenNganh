import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/models/group_question_model.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/question/widget/dialog_group_question.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'controllers/group_question_controller.dart';
import 'widget/group_question_item.dart';

class ManagerGroupQuestion extends StatefulWidget {
  @override
  _ManagerGroupQuestionState createState() => _ManagerGroupQuestionState();
}

class _ManagerGroupQuestionState extends State<ManagerGroupQuestion> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _groupQuestionController = Get.put(GroupQuestionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _groupQuestionController.initialController();
    _groupQuestionController.getGroupQuestion();
    // scrollController.addListener(() {
    //   if (scrollController.position.atEdge) {
    //     if (scrollController.position.pixels == 0) {
    //       // You're at the top.
    //     } else {
    //       discountController.getAllDiscount();
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: AppColors.LIGHT,
        key: _scaffoldKey,
        drawer: Container(
          width: 70.w,
          child: Drawer(
            child: DrawerLayoutAdmin(status: 5),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Text(
            'Quản lý bộ câu hỏi',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Get.toNamed(Routes.MANAGER_QUESTION);
                showDialogFCM(context, '', '');
              },
              icon: Icon(
                PhosphorIcons.plus,
                size: 7.w,
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GetBuilder<GroupQuestionController>(
                    init: _groupQuestionController,
                    builder: (_) => ListView.builder(
                      controller: scrollController,
                      itemCount: _.groupQuestion.length,
                      itemBuilder: (context, index) {
                        return GroupQuestionItem(
                          groupQuestion: GroupQuestionModel.fromMap(
                              _.groupQuestion[index]),
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Container(
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              // ),
            ],
          ),
          // bottomNavigationBar: CartTotal(),
        ));
  }
}
