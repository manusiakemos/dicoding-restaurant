import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/restaurant_list_widget.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body:  const RestaurantListWidget(),
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
