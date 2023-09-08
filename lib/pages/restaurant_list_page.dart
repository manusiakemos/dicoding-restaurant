// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/heading.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/';

  const RestaurantListPage({super.key}); // Fixed the constructor

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(title: 'Restaurant'),
              SubHeading(title: 'Recommendation restaurant for you'),
              SizedBox(height: 15),
              ScrollViewList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollViewList extends StatelessWidget {
  const ScrollViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/json/restaurants.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            // final dynamic restaurantData =  Restaurant.fromJson(snapshot.data);
            var json = jsonDecode(snapshot.data.toString());
            Restaurant parsedRestaurant = Restaurant.fromJson(json);
            return ListView.builder(
              itemCount: parsedRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                final item = parsedRestaurant.restaurants[index];
                return GestureDetector(
                  onTap: () { //navigate to restaurant detail page
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: item,
                    );
                  },
                  child: Card(
                    // Define the shape of the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Define how the card's content should be clipped
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // Define the child widget of the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add padding around the row widget
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Add an image widget to display an image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                // Image border
                                child: Image.network(
                                  item.pictureId,
                                  height: 100,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Add some spacing between the image and the text
                              Container(width: 20),
                              // Add an expanded widget to take up the remaining horizontal space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 5),
                                    Heading(
                                      title: item.name,
                                      size: "md",
                                    ),
                                    Container(height: 5),
                                    SubHeading(title: item.city),
                                    Container(height: 10),
                                    Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star),
                                        SizedBox(width: 5),
                                        SubHeading(
                                            title: item.rating.toString()),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator(); // Loading indicator
          }
        },
      ),
    );
  }

  Future<String> _loadRestaurantData(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/json/restaurants.json');
    return jsonString;
  }
}
