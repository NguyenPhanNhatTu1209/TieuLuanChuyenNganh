import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:freshfood/src/models/address.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AdminController extends GetxController {
  List<UserModel> listUser = [];
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  List<BarChartGroupData> listOrderNumber = [];
  List<FlSpot> listOrderMoney = [];
  List<dynamic> listProduct = [];
  dynamic resultStatisticUser;

  int skip = 1;
  int skipStaff = 1;

  initialController() {
    skip = 1;
    skipStaff = 1;
    listUser = [];
    listOrderMoney = [];
    listProduct = [];
    listOrderNumber = [];
  }

  getAllUser({String search}) {
    if (skip != -1) {
      AdminRepository().getAllUser(search, skip, 10, 0).then((value) {
        if (value.isNotEmpty) {
          listUser
              .addAll(value.map((data) => UserModel.fromMap(data)).toList());
          skip++;
          update();
        } else {
          skip = -1;
          update();
        }
      });
    }
  }

  getAllStaff({String search}) {
    if (skipStaff != -1) {
      AdminRepository().getAllUser(search, skipStaff, 10, 2).then((value) {
        if (value.isNotEmpty) {
          listUser
              .addAll(value.map((data) => UserModel.fromMap(data)).toList());
          skipStaff++;
          update();
        } else {
          skipStaff = -1;
          update();
        }
      });
    }
  }

  statisticOrder(dateStart, dateEnd) {
    String timeStart = '${dateStart.year}-${dateStart.month}-${dateStart.day}';
    String timeEnd = '${dateEnd.year}-${dateEnd.month}-${dateEnd.day}';
    AdminRepository().getstatisticOrder(timeStart, timeEnd).then((value) {
      if (value.isNotEmpty) {
        // listOrderNumber = makeGroupData(value);
        // update();
        final Color leftBarColor = const Color(0xff53fdd7);
        final Color rightBarColor = const Color(0xffff5182);
        int i = 0;
        for (i = 0; i < 7; i++) {
          listOrderNumber.add(makeGroupData(
              i, double.parse(value[i]['totalOrder'].toString())));
          listOrderMoney.add(
            FlSpot(double.parse(i.toString()),
                double.parse(value[i]['totalMoney'].toString())),
          );
          update();
        }
        // value.forEach((element) {});
        update();
      }
    });
  }

  statisticProduct() {
    AdminRepository().getstatisticProduct().then((value) {
      listProduct = value;
      update();
    });
  }

  statisticUser(String id) {
    AdminRepository().getStatisticUser(id).then((value) {

      resultStatisticUser = value;
      update();
    });
  }

  // List<BarChartGroupData> makeGroupData(List<dynamic> listData) {
  //   List<BarChartGroupData> result = [];
  //   final Color leftBarColor = const Color(0xff53fdd7);
  //   final Color rightBarColor = const Color(0xffff5182);
  //   listData.asMap().forEach((index, element) {
  //     result.add(BarChartGroupData(barsSpace: 4, x: index, barRods: [
  //       BarChartRodData(
  //         y: double.tryParse(element['totalOrder'].toString()),
  //         colors: [leftBarColor],
  //         width: 20.sp,
  //       ),
  //     ]));
  //     return result;
  //   });
  // }
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: 20.sp,
      ),
    ]);
  }
}
