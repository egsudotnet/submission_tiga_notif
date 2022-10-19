import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:submission_tiga_notif/utils/background_service.dart';
import 'package:submission_tiga_notif/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  String isSetScheduled = 'isSetScheduled'; 
  
  SchedulingProvider() {  
    _getIsScheduled();
  }

  bool get isScheduled => _isScheduled;
 
  Future<bool> scheduledNotification(bool value) async {
    _isScheduled = value;
      
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isSetScheduled, _isScheduled);

    if (_isScheduled) {
      if (kDebugMode) {
        print('Scheduling Activated');
      }
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Canceled');
      }
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
  
  void _getIsScheduled() async {
    final prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool(isSetScheduled) ?? false; 
    notifyListeners();
  }
  
}