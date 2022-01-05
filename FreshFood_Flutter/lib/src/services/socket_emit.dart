import 'dart:io';

import 'package:flutter/services.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:device_info/device_info.dart';

class SocketEmit {
  // void updateOrder({status, idOrder}) {
  //   socket.emit(
  //       'ORDER_CHANGE_STATUS_CSS',
  //       status == 2
  //           ? {
  //               'status': status,
  //               'idPackage': idOrder,
  //             }
  //           : {
  //               'status': status,
  //               'idOrder': idOrder,
  //             });
  // }

  void joinRoom({idRoom}) {
    socket.emit('JOIN_ROOM_CSS', {
      'idUser': idRoom,
      // 'idPackage': idPackage,
    });
  }

  void leaveRoom({idRoom}) {
    socket.emit('LEAVE_ROOM_CSS', {
      'idUser': idRoom,
    });
  }

  void sendMessage(dynamic message) {
    print("tin nhan gui nek");
    print({
      "message": message,
    });
    socket.emit('SEND_MESSAGE_CSS', {
      "message": message,
    });
  }

  void sendDeviceInfo() async {
    List<String> infos = await getDeviceDetails();
    print({
      "deviceUUid": infos[2],
      "deviceModel": infos[0],
      "appVersion": infos[3],
    });
    socket.emit('UPDATE_DEVICE_CSS', {
      "deviceUUid": infos[2],
      "deviceModel": infos[0],
      "appVersion": infos[3],
    });
  }

  Future<void> deleteDeviceInfo() async {
    List<String> infos = await getDeviceDetails();

    socket.emit('DELETE_DEVICE_CSS', {
      "deviceUUid": infos[2],
    });
  }

  Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    String appVersion;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
        appVersion = "1.0.0";
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
        appVersion = "1.0.0";
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return [deviceName, deviceVersion, identifier, appVersion];
  }

  // void setFeeUser(body) {
  //   socket.emit(
  //     'UPDATE_SHIPPING_CSS',
  //     body,
  //   );
  // }
}
