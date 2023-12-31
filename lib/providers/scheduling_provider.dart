import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../utils/background_service.dart';
import '../utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;
  Logger logger = Logger();

  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      logger.d('Scheduling enabled');
      notifyListeners();

      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );

      // return await AndroidAlarmManager.oneShotAt(
      //   DateTime.now(),
      //   1,
      //   BackgroundService.callback,
      //   exact: true,
      //   wakeup: true,
      // );
    } else {
      logger.d('Scheduling disabled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}