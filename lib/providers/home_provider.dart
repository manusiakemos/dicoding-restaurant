import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../pages/restaurant_detail_page.dart';
import '../utils/background_service.dart';
import '../utils/notification_helper.dart';

class HomeProvider extends ChangeNotifier {
  int navIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BuildContext context;

  HomeProvider({required this.context}) {
    _setNotification();
    notifyListeners();
  }

  void setNavIndex(int i) {
    navIndex = i;
    notifyListeners();
  }

  void _setNotification() {
    Logger logger = Logger();
    try {
      port.listen((_) async {
        await BackgroundService.callback();
      });
      _notificationHelper.selectedNotificationRestaurant(
        context,
        RestaurantDetailPage.routeName,
      );
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
