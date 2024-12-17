import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyTransactionsImageWidget extends StatelessWidget {
  MyTransactionsImageWidget(this.itemRenter, this.itemId, this.startDate, this.endDate, this.price, this.status,
      {super.key});

  final ItemRenter itemRenter;
  final String itemId;
  final String startDate;
  final String endDate;
  final int price;
  final String status;

  late String itemType;
  late String itemName;
  late String brandName;
  late String imageName;
  // Item item = Item(id: '-', owner: 'owner', type: 'dress', bookingType: 'rental', dateAdded: '01-01-2023', occasion: ['party'], style: 'classic', name: 'MISSING', brand: 'MISSING', colour: ['Black'], size: ['8'], length: 'midi', print: 'none', sleeve: 'short sleeve', rentPrice: 1200, buyPrice: 0, rrp: 16000, description: 'Short Description', bust: '', waist: '', hips: '', longDescription: '', imageId: [] );
  late Item item;


  String setItemImage() {
    itemType = toBeginningOfSentenceCase(item.type.replaceAll(RegExp(' +'), '_'));
    itemName = item.name.replaceAll(RegExp(' +'), '_');
    brandName = item.brand.replaceAll(RegExp(' +'), '_');
    imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
    return imageName;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    DateTime fromDate = DateTime.parse(startDate);
    DateTime toDate = DateTime.parse(endDate);
    String fromDateString = DateFormat('d MMMM, y').format(fromDate);
    String toDateString = DateFormat('d MMMM, y').format(toDate);
    // yMMMMd('en_US')
    for (Item d in allItems) {
      if (d.id == itemId) {
       
        item = d;
      }
    } 
    ColorFilter greyscale = const ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    if (fromDate.isAfter(DateTime.now().add(const Duration(days: 1))) && item.bookingType == 'rental') {
      greyscale = const ColorFilter.matrix(<double>[
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]);
    } else {
      greyscale = const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
    }
    // Ignoreing greyscale by adding the below, sort this out later
    // greyscale = const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColorFiltered(
                    colorFilter: greyscale,
                    child: Image.asset(
                        'assets/img/items2/${setItemImage()}',
                        fit: BoxFit.fitHeight,
                        height: width*0.25,
                        width: width*0.2))),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledBody('${item.name} from ${item.brand}', weight: FontWeight.normal,),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('From', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(fromDateString, color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('To', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(toDateString, color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Price', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody('${price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Status', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(status, color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
