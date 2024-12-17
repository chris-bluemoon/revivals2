import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:revivals/models/item.dart';
import 'package:revivals/shared/styled_text.dart';

class SummaryImageWidget extends StatelessWidget {
  SummaryImageWidget(this.item, {super.key});

  final Item item;

  late String itemType;
  late String itemName;
  late String brandName;
  late String imageName;

  String setItemImage() {
    itemType = toBeginningOfSentenceCase(item.type.replaceAll(RegExp(' +'), '_'));
    itemName = item.name.replaceAll(RegExp(' +'), '_');
    brandName = item.brand.replaceAll(RegExp(' +'), '_');
    imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
    return imageName;
  }
 
  // String getSize(int size) {
  //   String sizeString = size.toString();
  //   if (size.isOdd) {
  //     int lowerFigure = size - 1;
  //     int upperFigure = size + 1;
  //     sizeString = '$lowerFigure-$upperFigure';
  //   }
  //  
  //   return sizeString;
  // }
    String getSize(sizeArray) {
    String formattedSize = 'N/A';
    if (sizeArray.length == 1) {
      formattedSize = sizeArray.first;
    }
    if (sizeArray.length == 2) {
      String firstSize;
      String secondSize;
      firstSize = sizeArray.elementAt(0);
      secondSize = sizeArray.elementAt(1);
       formattedSize = '$firstSize-$secondSize';
    }
    return formattedSize;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; 
   
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: 
              Image.asset('assets/img/items2/${setItemImage()}', fit: BoxFit.fitHeight, height: 0.25*width, width: 0.2*width)),
              // Image.asset('assets/img/items2/${setItemImage()}', fit: BoxFit.fitHeight, height: width*0.125, width: width*0.1)),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledHeading('${item.name} from ${item.brand}'),
              const SizedBox(height: 5),
              // TODO Sort this out
              StyledBody('Size UK ${getSize(item.size)}', color: Colors.grey),
          ],)
        ],
      )

    );
  }
}