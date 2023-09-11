import 'package:dicoding_restaurant_app/widgets/atoms/makanan_card.dart';
import 'package:flutter/material.dart';

class MakananMinumanGridView extends StatelessWidget {
  final List<dynamic> listMakanan;
  ScrollController? scrollController;

  MakananMinumanGridView({required this.listMakanan, this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listMakanan.isEmpty) {
      return const Center(
        child: Text("No data available"),
      );
    }
    return GridView.count(
      shrinkWrap: true,
      primary: true,
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: listMakanan.map((e) => MakananCard(nama: e.name, harga: 100, gambar: 'http://via.placeholder.com/640x360')).toList(),
    );
  }
}
