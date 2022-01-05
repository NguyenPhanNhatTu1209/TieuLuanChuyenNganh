import 'package:intl/intl.dart';

final oCcy = new NumberFormat(",###", "en_US");

String formatMoney(double money) {
  String temp = "";

  // var save = (money) % (money / 1000).toInt();

  temp = money.toStringAsFixed(0);
  // if (money > 999999) {
  //   if (save > 0)
  //     temp = (money).toString();
  //   else
  //     temp = (money).toStringAsFixed(0);
  // } else if (money > 999999999) if (save > 0)
  //   temp = (money).toString();
  // else
  //   temp = (money).toStringAsFixed(0);
  // else {
  //   temp = (money).toString();
  // }
  // int count = 0;
  // for (var i = temp.length - 1; i < 0; i--) {
  //   if (temp[i] != '.') {
  //     count++;
  //     if(count ==3)
  //     temp.insert
  //   }
  // }

  temp =
      NumberFormat.simpleCurrency(name: 'VND').format(money); // 123.456,00 EUR

  return temp;
}
