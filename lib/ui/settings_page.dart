import 'dart:io';

import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_tiga_notif/common/styles.dart';
import 'package:submission_tiga_notif/provider/scheduling_provider.dart'; 
import 'package:submission_tiga_notif/widgets/custom_dialog.dart';
import 'package:submission_tiga_notif/widgets/platform_widget.dart'; 

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';
  static const String settingsTitle = 'Setting';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> { 
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(SettingsPage.settingsTitle),
      ),
      child: _buildList(context),
    );
  }

   Widget _buildList(BuildContext context) {  
    return 
        ChangeNotifierProvider<SchedulingProvider>(
      create: (_) =>
          SchedulingProvider(),
          child: Material(
            child: ListTile(
              title: const Text('Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
                 builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    activeColor: secondaryColor,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledNotification(value); 
                      }
                    },
                  );
                },
              ),
            ),
          ),
        );
  }
  
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
