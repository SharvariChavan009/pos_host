import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ApiMethods{
  static const addMethod = "add";
  static const substractMethod = "substract";

  static String convertDateFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    dateTime = dateTime.toLocal();
    String formattedDateString = DateFormat('dd-MM-yyyy , hh:mm a').format(dateTime);
    return formattedDateString;
  }
  static Future<String?> getCurrency() async {
    var box = await Hive.openBox('userData');
    var currency = box.get("currency");
    return currency;
  }
}


