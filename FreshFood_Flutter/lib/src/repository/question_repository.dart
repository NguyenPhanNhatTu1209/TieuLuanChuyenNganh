import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class QuestionRepository {
  Future<List<dynamic>> getAllQuestionByGroup(String id) async {
    var response = await HandleApis().get(
      '${ApiGateway.GET_ALL_QUESTION}/$id',
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<List<dynamic>> getAllQuestionToAnswer() async {
    var response = await HandleApis().get(
      ApiGateway.GET_ALL_QUESTION,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<Map<String, dynamic>> createQuestion({
    int time,
    String groupQuestion,
    String title,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
    bool isCorrectA = false,
    bool isCorrectB = false,
    bool isCorrectC = false,
    bool isCorrectD = false,
  }) async {
    var body = {
      'time': time,
      'title': title,
      'answerA': answerA,
      'answerB': answerB,
      'answerC': answerC,
      'answerD': answerD,
      'isTrueA': isCorrectA,
      'isTrueB': isCorrectB,
      'isTrueC': isCorrectC,
      'isTrueD': isCorrectD,
      'groupQuestion': groupQuestion,
    };
    var response = await HandleApis().post(
      ApiGateway.CREATE_QUESTION,
      body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>> updateQuestion({
    String id,
    int time,
    String groupQuestion,
    String title,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
    bool isCorrectA = false,
    bool isCorrectB = false,
    bool isCorrectC = false,
    bool isCorrectD = false,
  }) async {
    var body = {
      'id': id,
      'time': time,
      'title': title,
      'answerA': answerA,
      'answerB': answerB,
      'answerC': answerC,
      'answerD': answerD,
      'isTrueA': isCorrectA,
      'isTrueB': isCorrectB,
      'isTrueC': isCorrectC,
      'isTrueD': isCorrectD,
      'groupQuestion': groupQuestion,
    };
    var response = await HandleApis().put(
      ApiGateway.UPDATE_QUESTION,
      body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }
}
