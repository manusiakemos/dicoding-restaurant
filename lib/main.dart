import 'package:dicoding_restaurant_app/pages/home_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_search_page.dart';
import 'package:flutter/material.dart';
import 'common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.amber,
              secondary: Colors.amberAccent,
              background: const Color(0xFFf1f5f9),
            ),
        textTheme: myTextTheme,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            id: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
