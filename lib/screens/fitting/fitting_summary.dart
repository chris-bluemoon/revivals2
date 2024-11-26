import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();


class FittingSummary extends StatefulWidget {
  const FittingSummary({super.key});

  @override
  State<FittingSummary> createState() => _FittingSummaryState();
}

class _FittingSummaryState extends State<FittingSummary> {
    void handleSubmit(String renterId, List<String> itemArray, String bookingDate,
      int price, String status) {
      Provider.of<ItemStore>(context, listen: false).addFittingRenter(FittingRenter(
        id: uuid.v4(),
        renterId: renterId,
        itemArray: itemArray,
        bookingDate: bookingDate,
        price: price,
        status: status,
      ));
    }

  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
  return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledTitle('FITTING SUMMARY'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
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
                child: Icon(Icons.close, size: width*0.06),
              )),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('ADD FITTING RENTER'),
            onPressed: () {}
          ),
        ],
      )
    );
  }
}