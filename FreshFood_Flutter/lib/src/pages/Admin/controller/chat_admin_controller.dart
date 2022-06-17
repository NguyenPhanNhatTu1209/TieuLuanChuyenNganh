import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/services/socket_emit.dart';

class MessageAdminController extends ChangeNotifier {
  List<dynamic> listRoom = [];
  List<dynamic> listMessage = [];
  int skipRoom = 0;
  int skipMessage = 0;

  StreamController<List<dynamic>> _listRoomController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> _listMessageController =
      StreamController<List<dynamic>>.broadcast();

  initialRoom() {
    skipRoom = 0;
    listRoom.clear();
    _listRoomController.add(listRoom);
  }

  initialMessage(String idUser) {
    joinChannel(idUser);
    skipMessage = 0;
    listMessage.clear();
    _listMessageController.add(listRoom);
    if (userProvider.user.role == 1) {
      addToSeens(idUser);
    }
  }

  addToSeens(String idUser) {
    int index = listRoom.indexWhere((element) => element['idRoom'] == idUser);
    if (index != -1) {
      (listRoom[index]['seenByUser'] as List<dynamic>)
          .add(userProvider.user.id);
      _listRoomController.add(listRoom);
      notifyListeners();
    }
  }

  getListRoom() {
    if (skipRoom != -1) {
      UserRepository().getRoom(skipRoom).then((value) {
        if (value.length > 0) {
          listRoom.addAll(value);
          _listRoomController.add(listRoom);
          skipRoom += value.length;
          notifyListeners();
        } else {
          skipRoom = -1;
          notifyListeners();
        }
      });
    }
  }

  getListMessage(String idRoom) {
    if (skipMessage != -1) {
      UserRepository()
          .getMessage(
        skip: skipMessage,
        idRoom: idRoom,
      )
          .then((value) {
        if (value.length > 0) {
          listMessage.addAll(value);
          _listMessageController.add(listMessage);
          skipMessage += value.length;
          notifyListeners();
        } else {
          skipMessage = -1;
          notifyListeners();
        }
      });
    }
  }

  insertMessage(dynamic messages) {
    int index =
        listMessage.indexWhere((element) => element['_id'] == messages['_id']);
    if (index == -1) {
      listMessage.insert(0, messages);
      _listMessageController.add(listMessage);
      skipMessage++;
      if (userProvider.user.role == 1) {
        addLastMessage(
            messages['message'], messages['idRoom'], messages['updatedAt']);
      }
      notifyListeners();
    }
  }

  addLastMessage(String message, String idUser, String updatedAt) {
    int index = listRoom.indexWhere((element) => element['idRoom'] == idUser);
    if (index != -1) {
      listRoom[index]['message'] = message;
      listRoom[index]['updatedAt'] = updatedAt;
      listRoom.insert(0, listRoom[index]);
      listRoom.removeAt(index + 1);
      _listRoomController.add(listRoom);
      notifyListeners();
    }
  }

  joinChannel(String idUser) {
    SocketEmit().joinRoom(idRoom: idUser);
  }

  leaveChannel(idUser) {
    SocketEmit().leaveRoom(idRoom: idUser);
  }

  Stream<List<dynamic>> get listRooms => _listRoomController.stream;
  Stream<List<dynamic>> get listMessages => _listMessageController.stream;
}

MessageAdminController messageAdminController = MessageAdminController();
