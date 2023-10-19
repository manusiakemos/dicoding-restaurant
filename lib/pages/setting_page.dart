import 'dart:io';

import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/providers/preference_provider.dart';
import 'package:dicoding_restaurant_app/providers/scheduling_provider.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    NotificationHelper notificationHelper = NotificationHelper();

    return Consumer<PreferenceProvider>(
      builder: (BuildContext context, PreferenceProvider preferenceProvider, Widget? child) {
        return Consumer<SchedulingProvider>(
          builder: (BuildContext context, SchedulingProvider schedulingProvider, Widget? child) {
            void setReminder(bool value) {
              schedulingProvider.scheduledReminder(value);
              preferenceProvider.toggleDailyReminder(value);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: secondaryColor,
                    title: Text(
                      'Enable Daily Reminder',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    value: preferenceProvider.isDailyReminderActive,
                    onChanged: (bool value) async {
                      setReminder(value);
                      if (value) {
                        await notificationHelper.showNotificationWithNoBody(
                            flutterLocalNotificationsPlugin, 'Daily Reminder is on');
                      } else {
                        await notificationHelper.showNotificationWithNoBody(
                            flutterLocalNotificationsPlugin, 'Daily Reminder is off');
                      }
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showDialogPermissionIsPermanentlyDenied(BuildContext context) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final NotificationHelper notificationHelper = NotificationHelper();
    if (Platform.isAndroid) {
      notificationHelper.requestAndroidPermission(flutterLocalNotificationsPlugin);
    } else if (Platform.isIOS) {
      notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
    }
  }
}
