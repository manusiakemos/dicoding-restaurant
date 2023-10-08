import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_list_provider.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/navbar.dart';
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
    child: const RestaurantListPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _homeWidget,
      appBar: AppBar(
        toolbarOpacity: 1,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        surfaceTintColor: primaryColor,
        flexibleSpace: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: const NavbarWidget(),
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: primaryColor,
      ),
    );
  }
}
