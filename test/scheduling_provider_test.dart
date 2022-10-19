import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_tiga_notif/provider/scheduling_provider.dart';
void main() { 
    SchedulingProvider schedulingProvider = SchedulingProvider();
    setUp(() {
      schedulingProvider = SchedulingProvider();
    });
 
    WidgetsFlutterBinding.ensureInitialized();

    test('should have true value when module call with true value', () {
      // act
      schedulingProvider.scheduledNotification(true);
      // assert
      var result = schedulingProvider.isScheduled == true;
      expect(result, true);
    });
}