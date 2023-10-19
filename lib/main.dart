import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/preferences/preference_helper.dart';
import 'package:dicoding_restaurant_app/pages/home_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_search_page.dart';
import 'package:dicoding_restaurant_app/providers/preference_provider.dart';
import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_list_provider.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_search_provider.dart';
import 'package:dicoding_restaurant_app/providers/scheduling_provider.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/styles.dart';
import 'data/model/restaurant.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();
  final NotificationHelper notificationHelper = NotificationHelper();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
    notificationHelper.requestAndroidPermission(flutterLocalNotificationsPlugin);
  } else if (Platform.isIOS) {
    notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DbRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => RestaurantListProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => PreferenceProvider(
            preferenceHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.black,
                secondary: Colors.amber,
                background: Colors.black,
              ),
          textTheme: myTextTheme,
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) {
            return const HomePage();
          },
          RestaurantSearchPage.routeName: (context) {
            return const RestaurantSearchPage();
          },
          RestaurantDetailPage.routeName: (context) {
            return RestaurantDetailPage(
              restaurantData: ModalRoute.of(context)!.settings.arguments as Restaurant,
            );
          },
        },
      ),
    );
  }
}
