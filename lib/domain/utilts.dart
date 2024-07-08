
import 'package:intl/intl.dart';

class Utilts{

  static String getMesssageTime(DateTime dateTime){
    if(isYesterDay(dateTime: dateTime)){
      return 'Вчера ${dateTime.hour}:${dateTime.minute}';
    }else if(isToday(dateTime: dateTime)){
      return '${dateTime.hour}:${dateTime.minute}';
    }else{
      return DateFormat.MMMMEEEEd().format(dateTime);
    }
  }


  static bool isYesterDay({required DateTime dateTime}) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  return dateTime.year == yesterday.year &&
      dateTime.month == yesterday.month &&
      dateTime.day == yesterday.day;
}
static bool isToday({required DateTime dateTime}) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day);
  return dateTime.year == yesterday.year &&
      dateTime.month == yesterday.month &&
      dateTime.day == yesterday.day;
}}