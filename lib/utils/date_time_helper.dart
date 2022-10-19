import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
 
class DateTimeHelper {
 static DateTime format() { 
   final now = DateTime.now();
   final dateFormat = DateFormat('y/M/d');
   const timeSpecific = "11:00:00"; 
   final completeFormat = DateFormat('y/M/d H:m:s');
  
   final todayDate = dateFormat.format(now);
   final todayDateAndTime = "$todayDate $timeSpecific";
   var resultToday = completeFormat.parseStrict(todayDateAndTime);
 
   var formatted = resultToday.add(const Duration(days: 1));
   final tomorrowDate = dateFormat.format(formatted);
   final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
   var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);
 
   if (kDebugMode) {
     print("Alarm start at $resultToday");
   }
   return now.isAfter(resultToday) ? resultTomorrow : resultToday;
 }
}