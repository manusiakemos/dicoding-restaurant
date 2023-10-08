import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_list_provider.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/home_title.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Widget _homeWidget = ChangeNotifierProvider<RestaurantListProvider>(
    create: (_) => RestaurantListProvider(apiService: ApiService()),
    child: Container(
      padding: const EdgeInsets.only(top: 32),
      margin: const EdgeInsets.only(top: 32),
      child: RestaurantListPage(),
    ),
  );

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _homeWidget,
      appBar: AppBar(
        leading: _homeWidget,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      navigationBar: const CupertinoNavigationBar(
        leading: HomeTitle(),
        backgroundColor: primaryColor,
      ),
      child: _homeWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
