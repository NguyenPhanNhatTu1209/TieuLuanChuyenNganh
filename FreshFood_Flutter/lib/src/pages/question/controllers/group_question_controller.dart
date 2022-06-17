import 'dart:async';
import 'package:freshfood/src/repository/group_question_repository.dart';
import 'package:get/get.dart';

class GroupQuestionController extends GetxController {
  List<dynamic> groupQuestion = [];
  StreamController<List<dynamic>> _listGroupQuestionController =
      StreamController<List<dynamic>>.broadcast();

  initialController() {
    groupQuestion = [];
  }

  getGroupQuestion() {
    GroupQuestionRepository().getGroupQuestion().then((value) {
      if (value.isNotEmpty) {
        groupQuestion.addAll(value);
        _listGroupQuestionController.add(groupQuestion);
        update();
      }
    });
  }

  changeStatus(int index, bool status) {
    GroupQuestionRepository()
        .updateStatusGroupQuestion(groupQuestion[index]['id'], status)
        .then((value) {
      if (status) {
        groupQuestion.asMap().forEach((i, element) {
          element['isActive'] = i == index;
        });
      } else {
        groupQuestion[index]['isActive'] = status;
      }
      update();
    });
  }

  Stream<List<dynamic>> get listGroupQuestion =>
      _listGroupQuestionController.stream;
}
