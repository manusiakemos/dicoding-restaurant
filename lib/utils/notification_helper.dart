import 'dart:convert';
import 'dart:math';

import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_list.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/restaurant_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import '../data/model/received_notification.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          Map<String, dynamic> jsonMap = jsonDecode(payload!);
          didReceiveLocalNotificationSubject.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: Restaurant.fromJson(jsonMap),
            ),
          );
        });

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          logger.d('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  void requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void requestAndroidPermission(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void configureDidReceiveLocalNotificationSubject(BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title!) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body!) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(context, route, arguments: receivedNotification);
              },
            )
          ],
        ),
      );
    });
  }

  Future<void> showNotificationWithNoBody(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, String message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(_channelId, _channelName,
        channelDescription: _channelDesc, importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message,
      null,
      platformChannelSpecifics,
      payload: '',
    );
  }

  Future<void> showNotificationRestaurant(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantList result) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(_channelId, _channelName,
        channelDescription: _channelDesc, importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final randomIndex = Random().nextInt(result.restaurants.length);
    final restaurant = result.restaurants[randomIndex];

    await flutterLocalNotificationsPlugin.show(
      0,
      "Today's restaurant",
      restaurant.name,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void selectedNotificationRestaurant(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      Map<String, dynamic> jsonMap = jsonDecode(payload!);
      Restaurant restaurant = Restaurant.fromJson(jsonMap);
      await Navigator.pushNamed(
        context,
        route,
        arguments: restaurant,
      );
    });
  }
}
