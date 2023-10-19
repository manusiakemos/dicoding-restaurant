import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferenceHelper({required this.sharedPreferences});

  static const String dailyReminderPrefs = 'dailyReminder';

  Future<bool> get isActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminderPrefs) ?? false;
  }

  void toggleDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminderPrefs, value);
  }
}
