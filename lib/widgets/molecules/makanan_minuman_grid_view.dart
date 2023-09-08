import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/makanan_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MakananMinumanGridView extends StatelessWidget {
  final List<dynamic> listMakanan;
  Logger logger = Logger();

  MakananMinumanGridView({required this.listMakanan, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listMakanan.isEmpty) {
      return const Center(
        child: Text("No data available"),
      );
    }
    return SizedBox(
      height: listMakanan.length * 100,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: listMakanan.map((e) => MakananCard(nama: e.name, harga: 100, gambar: 'http://via.placeholder.com/640x360')).toList(),
      ),
    );
  }
}
