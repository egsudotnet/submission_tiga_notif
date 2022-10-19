import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_tiga_notif/common/navigation.dart';
import 'package:submission_tiga_notif/common/styles.dart';
import 'package:submission_tiga_notif/provider/restaurant_favorite_provider.dart';
import 'package:submission_tiga_notif/ui/add_comment.dart';
import 'package:submission_tiga_notif/ui/restaurant_detail_page.dart';
import 'package:submission_tiga_notif/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:submission_tiga_notif/ui/settings_page.dart';
import 'package:submission_tiga_notif/utils/background_service.dart';
import 'package:submission_tiga_notif/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
   final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
   await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<RestaurantFavoriteProvider>(
      create: (_) => RestaurantFavoriteProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.white,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String),
          AddCommentPage.routeName: (context) => AddCommentPage(
              id: ModalRoute.of(context)?.settings.arguments as String), 
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ), 
    );
  }
}
