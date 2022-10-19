import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:submission_tiga_notif/main.dart';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:submission_tiga_notif/utils/notification_helper.dart'; 
 
final ReceivePort port = ReceivePort();
 
class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
 
  BackgroundService._internal() {
    _instance = this;
  }
 
  factory BackgroundService() => _instance ?? BackgroundService._internal();
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }
 
  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    var restaurant = await ApiService().mainList();  
    int max = restaurant.restaurants.length-1; 
    int index= Random().nextInt(max);
     
    var result = await ApiService().detail(restaurant.restaurants[index].id); 

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);
 
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  } 
}