import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyVerifyAdminImageWidget extends StatefulWidget {
  const MyVerifyAdminImageWidget(this.renter,
  // const MyVerifyAdminImageWidget(this.renterImage, this.name,
      {super.key});

  // final Image renterImage;
  final Renter renter;

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
                child: SizedBox(
                  height: width * 0.25,
                  width: width * 0.2,
                  child: thisImage),
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StyledBody(widget.renter.name, weight: FontWeight.normal,),
                    SizedBox(width: width * 0.3),
                    if (widget.renter.verified == 'pending') ElevatedButton(
                      onPressed: () {
                        Renter r = widget.renter;
                        r.verified = 'verified';
                        Provider.of<ItemStore>(context, listen: false).saveRenter(r);
                      }, 
                      child: const StyledBody('APPROVE')
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Email', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(widget.renter.email, color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Location', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(widget.renter.settings[0], color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Created', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(widget.renter.creationDate, color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Status', color: Colors.grey, weight: FontWeight.normal)),
                      SizedBox(width: width * 0.01),
                      StyledBody(widget.renter.verified, color: Colors.grey, weight: FontWeight.normal),
                    ],
                ),
              ],
            )
          ],
        ));
  }
}
