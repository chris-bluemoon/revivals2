import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class LedgerEntryWidget extends StatelessWidget {
  LedgerEntryWidget(this.itemRenter, {super.key});

  final ItemRenter itemRenter;

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
                      child: StyledBody(itemRenter.renterId, color: Colors.grey, weight: FontWeight.normal)),
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
                    StyledBody(DateFormat('E, d MMMM y').format(DateTime.now()), color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Time', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    StyledBody(DateFormat('HH:mm').format(DateTime.now()), color: Colors.grey, weight: FontWeight.normal),

                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.2,
                      child: const StyledBody('Price', color: Colors.grey, weight: FontWeight.normal)),
                    SizedBox(width: width * 0.01),
                    // StyledBody('${price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
                  ],
                ),
                // StyledBody('Price ${price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
              ],
            )
          ],
        ));
  }
}
