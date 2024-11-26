import 'package:flutter/material.dart';

class FittingItemImage extends StatelessWidget {
  const FittingItemImage(this.imageFileName, {super.key});

  final String imageFileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(2),
      // height: 100,
      // width: 100,
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(width: 1),
      ),
      child: Image.asset('assets/img/items2/$imageFileName')
    );
  }
}