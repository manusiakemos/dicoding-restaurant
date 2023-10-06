import 'package:dicoding_restaurant_app/widgets/atoms/badge_widget.dart';
import 'package:flutter/material.dart';

class MakananMinumanGridWidget extends StatelessWidget {
  final List<dynamic> listMakanan;

  const MakananMinumanGridWidget({required this.listMakanan, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listMakanan.isEmpty) {
      return const Center(
        child: Text("No data available"),
      );
    }
    return Wrap(
      verticalDirection: VerticalDirection.down,
      direction: Axis.horizontal,
      children: listMakanan.map((e) => BadgeWidget(nama: e.name)).toList(),
    );
  }
}
