import 'package:dicoding_restaurant_app/data/preferences/preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}) {
    _getDailyReminder();
  }

  bool _isActive = false;

  bool get isDailyReminderActive => _isActive;

  Logger logger = Logger();

  void _getDailyReminder() async {
    _isActive = await preferenceHelper.isActive;
    notifyListeners();
  }

  void toggleDailyReminder(bool value) {
    preferenceHelper.toggleDailyReminder(value);
    _getDailyReminder();
  }
}
