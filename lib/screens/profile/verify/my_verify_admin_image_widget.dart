import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyVerifyAdminImageWidget extends StatelessWidget {
  const MyVerifyAdminImageWidget(this.name,
  // const MyVerifyAdminImageWidget(this.renterImage, this.name,
      {super.key});

  // final Image renterImage;
  final String name;

  // String setItemImage() {
  //   itemType = toBeginningOfSentenceCase(item.type.replaceAll(RegExp(' +'), '_'));
  //   itemName = item.name.replaceAll(RegExp(' +'), '_');
  //   brandName = item.brand.replaceAll(RegExp(' +'), '_');
  //   imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
  //   return imageName;
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                    'assets/img/items2/artsy_transparent.png',
                    fit: BoxFit.fitHeight,
                    height: width*0.25,
                    width: width*0.2)),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledBody(name, weight: FontWeight.normal,),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('From', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    const StyledBody('Date String', color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('To', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    const StyledBody('Date String', color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Price', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    const StyledBody('Anything else', color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                SizedBox(
                  width: width * 0.2,
                  child: const StyledBody('Status', color: Colors.grey, weight: FontWeight.normal)),
                SizedBox(width: width * 0.01),
                // StyledBody('Price ${price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
              ],
            )
          ],
        ));
  }
}
