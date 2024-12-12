import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class SetPricing extends StatefulWidget {
  const SetPricing(this.productType, this.title, this.colour, this.retailPrice, this.shortDesc,
    this.longDesc, this.imagePath, {super.key});

final String productType;
final String title;
final String colour;
final String retailPrice; 
final String shortDesc;
final String longDesc;
final List<String> imagePath;

  @override
  State<SetPricing> createState() => _SetPricingState();
}

class _SetPricingState extends State<SetPricing> {
  @override
  void initState() {
    super.initState();
  }

  bool formComplete = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('SET PRICING'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SingleChildScrollView(
        ),
                          bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (!formComplete) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('CONTINUE', weight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (formComplete) Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      handleSubmit();
                      Navigator.of(context).popUntil((route) => route.isFirst);

                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('SUBMIT', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),   
      );
  }
  handleSubmit() {
    String ownerId = Provider.of<ItemStore>(context, listen: false).renter.id;
    Provider.of<ItemStore>(context, listen: false).addItem(Item(
        id: uuid.v4(),
        owner: ownerId,
        type: widget.productType,
        bookingType: allItems[0].bookingType,
        occasion: allItems[0].occasion,
        dateAdded: allItems[0].dateAdded,
        style: allItems[0].style,
        name: widget.title,
        brand: allItems[0].brand,
        colour: [widget.colour],
        size: ['6'],
        length: allItems[0].length,
        print: allItems[0].print,
        sleeve: allItems[0].sleeve,
        rentPrice: int.parse(widget.retailPrice.substring(1)),
        buyPrice: allItems[0].buyPrice,
        rrp: allItems[0].rrp,
        description: widget.shortDesc,
        bust: allItems[0].bust,
        waist: allItems[0].waist,
        hips: allItems[0].hips,
        longDescription: widget.longDesc,
        imageId: widget.imagePath,
        status: 'submitted'
        // imageId: allItems[0].imageId,
        ));
  }
}
