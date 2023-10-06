import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Widget _homeWidget = ChangeNotifierProvider<RestaurantProvider>(
    create: (_) => RestaurantProvider(apiService: ApiService()),
    child: const RestaurantListPage(),
  );

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _homeWidget,
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.black87,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: primaryColor,
          middle: Text('Restaurant', style: TextStyle(color:secondaryColor)),
        ),
        child: _homeWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
