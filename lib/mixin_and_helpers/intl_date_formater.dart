import 'package:intl/intl.dart';

class DateFormater {
  static String getFormatedDate(DateTime dateTime){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime getFormatedDateFromString(String date){
    return DateTime.parse(date);
  }

  static String getFormatedDateTime(DateTime dateTime){
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String getFormatedTime(String time){
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
  }

  static String getFormatedTimeHHMMSS(String time){
    return DateFormat.Hms().format(DateFormat("HH:mm").parse(time));
  }
}