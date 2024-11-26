import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyFittingsAdminImageWidget extends StatelessWidget {
  MyFittingsAdminImageWidget(this.fittingRenter, this.bookingDate, this.price, this.status, {super.key});

  final FittingRenter fittingRenter;
  final String bookingDate;
  final int price;
  final String status;

  late String itemType;
  late String itemName;
  late String brandName;
  late String imageName;


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
    // List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    // DateTime bookingDate = DateTime.parse(bookingDate);
    // String bookingDateString = DateFormat('d MMMM, y').format(bookingDate);
    // yMMMMd('en_US')
    DateTime convertedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(bookingDate) ;

    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Row(
          children: [
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.asset(
            //         'assets/img/items2/${setItemImage()}',
            //         fit: BoxFit.fitHeight,
            //         height: width*0.25,
            //         width: width*0.2)),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // StyledBody('${item.name} from ${item.brand}', weight: FontWeight.normal,),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.6,
                      child: StyledBody(fittingRenter.renterId, color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Date', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(DateFormat('E, d MMMM y').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Time', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(DateFormat('HH:mm').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),

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
                if (status == 'booked') Row(
                  children: [
                    SizedBox(width: width * 0.01),
                    ElevatedButton(
                      onPressed: () {
                        fittingRenter.status = 'paid';
                        Provider.of<ItemStore>(context, listen: false).saveFittingRenter(fittingRenter);
                      }, 
                      child: const Text('MARK AS PAID'))
                  ],
                ),
                // StyledBody('Price ${price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
              ],
            )
          ],
        ));
  }
}
