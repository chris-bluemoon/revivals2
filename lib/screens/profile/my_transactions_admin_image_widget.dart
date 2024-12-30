import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/models/ledger.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class MyTransactionsAdminImageWidget extends StatefulWidget {
  const MyTransactionsAdminImageWidget(this.itemRenter, this.itemId, this.startDate, this.endDate, this.price, this.status,
      {super.key});

  final ItemRenter itemRenter;
  final String itemId;
  final String startDate;
  final String endDate;
  final int price;
  final String status;

  @override
  State<MyTransactionsAdminImageWidget> createState() => _MyTransactionsAdminImageWidgetState();
}

class _MyTransactionsAdminImageWidgetState extends State<MyTransactionsAdminImageWidget> {
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

    Image thisImage = Image.asset('assets/img/items2/No_Image_Available.jpg');
    late Item thisItem;
    @override
    void initState() {
      super.initState();
    for (Item it in Provider.of<ItemStore>(context, listen: false).items) {
      if (it.id == widget.itemId) {
        thisItem = it;
      }
    }
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      if (i.id == thisItem.imageId[0]) {
        setState(() {
          thisImage = i.imageId;
        }
        );
      }
    }}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    DateTime fromDate = DateTime.parse(widget.startDate);
    DateTime toDate = DateTime.parse(widget.endDate);
    String fromDateString = DateFormat('d MMMM, y').format(fromDate);
    String toDateString = DateFormat('d MMMM, y').format(toDate);
    // yMMMMd('en_US')
    for (Item d in allItems) {
      if (d.id == widget.itemId) {
       
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
                    child: SizedBox(
                      height: width * 0.25,
                      width: width * 0.2,
                      child: thisImage
                      ))),
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
                if (widget.status == 'booked') Row(
                  children: [
                    SizedBox(width: width * 0.01),
                    ElevatedButton(
                      onPressed: () {
                        widget.itemRenter.status = 'paid';
                        Provider.of<ItemStore>(context, listen: false).saveItemRenter(widget.itemRenter);
                        int runningBalance = 0;
                        for (Ledger l in Provider.of<ItemStore>(context, listen: false).ledgers) {
                          if (l.owner == Provider.of<ItemStore>(context, listen: false).renter.email) {
                            runningBalance = runningBalance + l.balance;
                          }
                        }
                        int newBalance = runningBalance + widget.itemRenter.price;
                        Ledger l = Ledger(id: uuid.v4(), reference: widget.itemRenter.id, owner: Provider.of<ItemStore>(context, listen: false).renter.email, date: DateTime.now().toString(), desc: 'Rental from ${widget.itemRenter.renterId}', amount: widget.itemRenter.price, balance: newBalance);
                        Provider.of<ItemStore>(context, listen: false).addLedger(l);
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
