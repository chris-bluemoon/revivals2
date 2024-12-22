import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyVerifyAdminImageWidget extends StatefulWidget {
  const MyVerifyAdminImageWidget(this.name,
  // const MyVerifyAdminImageWidget(this.renterImage, this.name,
      {super.key});

  // final Image renterImage;
  final String name;

  @override
  State<MyVerifyAdminImageWidget> createState() => _MyVerifyAdminImageWidgetState();
}

class _MyVerifyAdminImageWidgetState extends State<MyVerifyAdminImageWidget> {
  // String setItemImage() {
  Image thisImage = Image.asset('assets/img/items2/No_Image_Available.jpg',
                      fit: BoxFit.fitHeight,
                    height: 200,
                    width: 100);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      log('ItemImage path: ${i.id}');
      log('Renter path: ${Provider.of<ItemStore>(context, listen: false).renter.imagePath}');
      if (i.id == Provider.of<ItemStore>(context, listen: false).renter.imagePath) {
        setState(() {
          thisImage = i.imageId;
        }
        );
      }
    }
    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: thisImage,
                    // fit: BoxFit.fitHeight,
                    // height: width*0.25,
                    // width: width*0.2)),
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledBody(widget.name, weight: FontWeight.normal,),
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
