import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:freshfood/src/services/socket_emit.dart';
import 'package:freshfood/src/repository/user_repository.dart';

class ChatProvider extends ChangeNotifier {
  String channelId;
  int skip = 0;
  List<dynamic> _messages = [];
  StreamController<List<dynamic>> _messagesController =
      StreamController<List<dynamic>>.broadcast();
  initial() {
    _messages.clear();
    _messagesController.add(_messages);
    skip = 0;
    channelId = null;
  }

  insertMessage(dynamic messages) {
    int index =
        _messages.indexWhere((element) => element['_id'] == messages['_id']);
    if (index == -1) {
      _messages.insert(0, messages);
      _messagesController.add(_messages);
      skip++;
      notifyListeners();
    }
  }

  joinChannel({String idRoom}) {
    SocketEmit().joinRoom(
      idRoom: idRoom,
    );
    notifyListeners();
  }

  leaveChannel({String idRoom}) {
    channelId = null;
    SocketEmit().leaveRoom(
      idRoom: idRoom,
    );
    notifyListeners();
  }

  getMessage(String idRoom) {
    if (skip != -1) {
      UserRepository()
          .getMessage(
        skip: skip,
        idRoom: idRoom,
      )
          .then((value) {
        if (value.length > 0) {
          skip += value.length;
          addMoreMessage(value);
        } else {
          skip = -1;
        }
      });
    }
  }

  addMoreMessage(List<dynamic> messages) {
    _messages.addAll(messages);
    _messagesController.add(_messages);
    notifyListeners();
  }

  Stream<List<dynamic>> get listMessage => _messagesController.stream;
}

ChatProvider chatProvider = ChatProvider();
