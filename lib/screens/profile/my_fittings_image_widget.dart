import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';


class MyUpcomingFittingsImageWidget extends StatefulWidget {
  const MyUpcomingFittingsImageWidget(this.fittingRenter, this.itemIds, this.bookingDate, this.price, this.status,
      {super.key});

  final FittingRenter fittingRenter;
  final List itemIds;
  final String bookingDate;
  final int price;
  final String status;

  @override
  State<MyUpcomingFittingsImageWidget> createState() => _MyUpcomingFittingsImageWidgetState();
}

class _MyUpcomingFittingsImageWidgetState extends State<MyUpcomingFittingsImageWidget> {
  String imageName = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DateTime convertedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(widget.bookingDate) ;
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
                        // const StyledBody('TEST'),
                        StyledBody(DateFormat('E, d MMMM y').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: const StyledBody('Time', color: Colors.grey, weight: FontWeight.normal)),
                        SizedBox(width: width * 0.01),
                        StyledBody(DateFormat('Hm').format(convertedDate), color: Colors.grey, weight: FontWeight.normal),
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
                        StyledBody('${widget.price.toString()}${globals.thb}', color: Colors.grey, weight: FontWeight.normal),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: const StyledBody('Status', color: Colors.grey, weight: FontWeight.normal)),
                        SizedBox(width: width * 0.01),
                        StyledBody(widget.status, color: Colors.grey, weight: FontWeight.normal),
                      ],
                    ),
                    SizedBox(height: width * 0.03),
                  ],
                ),
                if (widget.fittingRenter.status != 'cancelled') Container(
                  padding: EdgeInsets.fromLTRB(width * 0.05,0,0,0),
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    onPressed: () {
                      setState(() {
                        widget.fittingRenter.status = 'cancelled';
                      });
                      Provider.of<ItemStore>(context, listen: false).saveFittingRenter(widget.fittingRenter);
                    },
                    child: const StyledBody('CANCEL', color: Colors.white)),
                ),
              ],
            ),
          ],
        ));
  }
}
