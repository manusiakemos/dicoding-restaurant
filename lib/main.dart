import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/pages/home_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_search_page.dart';
import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_list_provider.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/styles.dart';

void main() {
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
          create: (context) => DbRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
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
          RestaurantFavoritePage.routeName: (context) {
            return RestaurantFavoritePage();
          },
          RestaurantSearchPage.routeName: (context) {
            return RestaurantSearchPage();
          },
          RestaurantDetailPage.routeName: (context) {
            return RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            );
          },
        },
      ),
    );
  }
}
