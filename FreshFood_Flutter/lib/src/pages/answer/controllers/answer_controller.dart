import 'dart:async';
import 'dart:io';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/answer/widgets/bottom_sheet.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/repository/asnwer_repository.dart';
import 'package:freshfood/src/repository/question_repository.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/services/upload_storage.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AnswerController extends GetxController {
  List<dynamic> listQuestion = [];
  dynamic currentQuestion;
  int indexQuestion = 0;
  Timer _timer;
  int countDownTime = 10;
  int statusAnswer = 2;
  dynamic context;

  initController() {
    listQuestion = [];
    currentQuestion = {};
    indexQuestion = 0;
    statusAnswer = 2;
  }

  getAllQuestion() {
    listQuestion = [];
    QuestionRepository().getAllQuestionToAnswer().then((value) {
      if (value.length != 0 && !value.every((element) => element['isAnswer'])) {
        listQuestion.addAll(value);
        update();
        Get.toNamed(Routes.ANSWER_PAGE);
        nextQuestion();
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Chưa có bộ câu hỏi nào mới',
          subTitle: '',
        );
        getSnackBar.show();
      }
    });
  }

  cancleTimer() {
    _timer.cancel();
  }

  nextQuestion() {
    indexQuestion =
        listQuestion.where((element) => element['isAnswer']).toList().length +
            1;
    currentQuestion =
        listQuestion.firstWhere((element) => !element['isAnswer']);
    countDownTime = currentQuestion['time'];
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDownTime == 0) {
          timer.cancel();
          AnswerRepository()
              .createAnswer(questionId: currentQuestion['_id'], result: "E");
          chooseAnswer('E');
          bottomSheetAnswer(context, 'Tiếp theo', () {});
        } else {
          countDownTime--;
        }
        update();
      },
    );
  }

  chooseAnswer(String answer) {
    _timer.cancel();
    AnswerRepository()
        .createAnswer(questionId: currentQuestion['_id'], result: answer);
    if (answer != 'E' && currentQuestion['isTrue$answer']) {
      statusAnswer = 1;
      userProvider.user.point += 100;
    } else {
      statusAnswer = 0;
      userProvider.user.point += 50;
    }
    userProvider.setUserProvider(userProvider.user);
    currentQuestion['isAnswer'] = true;
  }

  readStatus() {
    if (statusAnswer == 0) {
      return 'Trả lời sai: +50';
    } else if (statusAnswer == 1) {
      return 'Trả lời đúng: +100';
    } else {
      return 'Chưa có câu trả lời';
    }
  }
}
