import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/screens/profile/create/view_image.dart';
import 'package:revivals/services/class_store.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key, required this.item, required this.itemNumber});

  final int itemNumber;
  final Item item;



  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  
  late String itemType;
  late String itemName;
  late String brandName;
  late String imageName;
  late Image thisImage;

  Image setItemImage() {
    // itemType = toBeginningOfSentenceCase(widget.item.type.replaceAll(RegExp(' +'), '_'));
    // itemName = widget.item.name.replaceAll(RegExp(' +'), '_');
    // brandName = widget.item.brand.replaceAll(RegExp(' +'), '_');
    // imageName = 'assets/img/items2/${brandName}_${itemName}_${itemType}_${widget.itemNumber}.jpg';
    // return imageName;
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      for (String j in widget.item.imageId) {
        if (i.id == j) {
          images.add(i.imageId);
        }
      }
    }
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      if (i.id == widget.item.imageId[widget.itemNumber-1]) {
        log(widget.item.imageId[widget.itemNumber-1].toString());
        setState(() {
          thisImage = i.imageId; 
        }
        );
      }
    }
    // images.add(thisImage);
    return thisImage;
  }

  late List<Image> images = [];

  @override
  Widget build(BuildContext context) {
                      // String itemImage = 'assets/img/items2/${widget.item.brand}_${widget.item.name}_Item_${widget.itemNumber}.jpg';
                      // return FittedBox(
                        
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => (ViewImage(images, 0))));
                          },
                          child: setItemImage(),
                        );
                        // return Image.asset(setItemImage(), fit: BoxFit.contain);
                        // child: Image.asset(setItemImage(),),
                        // fit: BoxFit.fill,
                      // );

  }
}
