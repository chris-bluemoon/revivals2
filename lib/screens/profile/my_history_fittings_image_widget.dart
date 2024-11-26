import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/shared/styled_text.dart';


class MyHistoryFittingsImageWidget extends StatelessWidget {

  const MyHistoryFittingsImageWidget(this.fittingRenter, this.itemIds, this.bookingDate, this.price, this.status,
      {super.key});

  final FittingRenter fittingRenter;
  final List itemIds;
  final String bookingDate;
  final int price;
  final String status;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DateTime convertedDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(bookingDate) ;
    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: width * 0.1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.03),
                    const StyledBody('FITTING APPOINTMENT', weight: FontWeight.normal,),
                    SizedBox(height: width * 0.03),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: const StyledBody('Date', color: Colors.grey, weight: FontWeight.normal)),
                        SizedBox(width: width * 0.01),
                        // StyledBody(DateFormat('yyyy-MM-dd').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),
                        StyledBody(DateFormat('E, d MMMM y').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),
                      ],
                    ),
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
                          child: const StyledBody('Stylist', color: Colors.grey, weight: FontWeight.normal)),
                        SizedBox(width: width * 0.01),
                        const StyledBody('Isabella', color: Colors.grey, weight: FontWeight.normal),
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
                    SizedBox(height: width * 0.03),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
