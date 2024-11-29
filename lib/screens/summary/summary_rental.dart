import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/summary/delivery_radio_widget.dart';
import 'package:revivals/screens/summary/rental_price_summary.dart';
import 'package:revivals/screens/summary/summary_image_widget.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/send_email2.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class SummaryRental extends StatefulWidget {
  SummaryRental(this.item, this.startDate, this.endDate, this.noOfDays,
      this.price, this.status, this.symbol,
      {super.key});

  final Item item;
  final DateTime startDate;
  final DateTime endDate;
  final int noOfDays;
  final int price;
  final String status;
  final String symbol;

  final ValueNotifier<int> deliveryPrice = ValueNotifier<int>(0);

  @override
  State<SummaryRental> createState() => _SummaryRentalState();
}

class _SummaryRentalState extends State<SummaryRental> {
  // final int i;
  @override
  Widget build(BuildContext context) {
    int pricePerDay = widget.price ~/ widget.noOfDays;

    void handleSubmit(String renterId, String itemId, String startDate,
        String endDate, int price, String status) {
      Provider.of<ItemStore>(context, listen: false).addItemRenter(ItemRenter(
        id: uuid.v4(),
        renterId: renterId,
        itemId: itemId,
        transactionType: 'rental',
        startDate: startDate,
        endDate: endDate,
        price: price,
        status: status,
      ));
    }

    void updateDeliveryPrice(int newDeliveryPrice) {
      setState(() {
        widget.deliveryPrice.value = newDeliveryPrice;
      });
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledTitle('REVIEW AND PAY'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  {Navigator.of(context).popUntil((route) => route.isFirst)},
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, width * 0.01, 0),
                child: Icon(Icons.close, size: width * 0.06),
              )),
        ],
        // bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(4.0),
        //     child: Container(
        //       color: Colors.grey[300],
        //       height: 1.0,
        //     )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SummaryImageWidget(widget.item),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.calendar_month_outlined, size: width * 0.06),
              const SizedBox(width: 20),
              StyledBody(DateFormat.yMMMd().format(widget.startDate)),
              const StyledBody('   -   '),
              StyledBody(DateFormat.yMMMd().format(widget.endDate)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.location_pin, size: width * 0.06),
              const SizedBox(width: 20),
              (Provider.of<ItemStore>(context, listen: false).renter.settings[0] == 'BANGKOK') ? const StyledBody('Bangkok, Thailand')
                : const StyledBody('Singapore')
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              color: Colors.grey[200],
              // height: 50,
              // width: 350,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (widget.noOfDays > 1)
                      ? StyledHeading(
                          'Renting for ${widget.noOfDays} days (at $pricePerDay${widget.symbol} per day)',
                          weight: FontWeight.normal,
                        )
                      : StyledHeading(
                          'Renting for ${widget.price}${widget.symbol}',
                          weight: FontWeight.normal)
                  // Text('($pricePerDay${globals.thb} per day)', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Divider(
            height: 1,
            indent: 50,
            endIndent: 50,
            color: Colors.grey[200],
          ),
          // SizedBox(height: 20),
          DeliveryRadioWidget(updateDeliveryPrice, widget.symbol),
          Divider(
            height: 1,
            indent: 50,
            endIndent: 50,
            color: Colors.grey[300],
          ),
          ValueListenableBuilder(
              valueListenable: widget.deliveryPrice,
              builder: (BuildContext context, int val, Widget? child) {
                log('Deliver fee being sent as val to RentalPriceSummary is: $val');
                return RentalPriceSummary(
                    widget.price, widget.noOfDays, val, widget.symbol);
              }),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    side: const BorderSide(width: 1.0, color: Colors.black),
                  ),
                  onPressed: () {
                    String email =
                        Provider.of<ItemStore>(context, listen: false)
                            .renter
                            .email;
                    String name = Provider.of<ItemStore>(context, listen: false)
                        .renter
                        .name;
                    String startDateText = widget.startDate.toString();
                    String endDateText = widget.endDate.toString();
                    handleSubmit(email, widget.item.id, startDateText,
                        endDateText, widget.item.rentPrice, widget.status);
                    String startDateTextForEmail =
                        DateFormat('yMMMd').format(widget.startDate);
                    String endDateTextForEmail =
                        DateFormat('yMMMd').format(widget.endDate);
                    EmailComposer2(
                            emailAddress: email,
                            itemType: widget.item.type,
                            userName: name,
                            itemName: widget.item.name,
                            itemBrand: widget.item.brand,
                            startDate: startDateTextForEmail,
                            endDate: endDateTextForEmail,
                            deliveryPrice: widget.deliveryPrice.value,
                            price: widget.price.toString(),
                            deposit: widget.item.rentPrice.toString(),
                            gd_image_id: widget.item.imageId[0])
                        .sendEmail2();
                    showAlertDialog(context, widget.item.type, width);
                    // Navigator.of(context).push(MaterialPageRoute(
                    // builder: (context) => (const Congrats())));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: const StyledHeading('CONFIRM', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String itemType, double width) {
    // Create button
    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        side: const BorderSide(width: 1.0, color: Colors.black),
      ),
      onPressed: () {
        // Navigator.of(context).pop();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: StyledBody("OK", color: Colors.white)),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: StyledHeading("Thank You!")),
      content: SizedBox(
        height: width * 0.15,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody("Your $itemType is being prepared,",
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody("Please check your", weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody("email for details.", weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
