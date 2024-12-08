import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:provider/provider.dart';
import 'package:revivals/globals.dart' as globals;
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/get_country_price.dart';
import 'package:revivals/shared/styled_text.dart';

// ignore: must_be_immutable
class ItemCard extends StatefulWidget {
  const ItemCard(this.item, this.isDesigner, this.isFittingScreen, {super.key});

  final Item item;
  final bool isDesigner;
  final bool isFittingScreen;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late String imageName;

  late String itemName;

  late String brandName;

  late String itemType;

  bool isFav = false;
  bool isFit = false;


String capitalize(string) {
  return string.codeUnitAt(0).toUpperCase() + string.substring(1).toLowerCase();
}

  String setItemImage() {
    itemType = toBeginningOfSentenceCase(widget.item.type.replaceAll(RegExp(' +'), '_'));
    // itemType = widget.item.type.replaceAll(RegExp(' +'), '_');
    itemName = widget.item.name.replaceAll(RegExp(' +'), '_');
    brandName = widget.item.brand.replaceAll(RegExp(' +'), '_');
    try {
      imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
    } catch(e) {
      imageName = 'SUNDRESS_Emilia_Dress_1.jpg';
    }
    return imageName;
  }

  bool isAFav(Item d, List favs) {
    if (favs.contains(d)) {
      return true;
    } else {
      return false;
    } 
  }

    void _toggleFav() {
    setState(() {
      if (isFav == true) {
        isFav = false;
      } else {
        isFav = true;
      }
    });}

  bool isAFit(String d, List fits) {
    if (fits.contains(d)) {
      return true;
    } else {
      return false;
    } 
  }

  void _toggleFit() {
    setState(() {
      if (isFit == true) {
        isFit = false;
      } else {
        isFit = true;
      }
    });}

  String convertedRentPrice = '-1';
  String convertedBuyPrice = '-1';
  String convertedRRPPrice = '-1';
  String symbol = '?';

  Image? myImage;

  @override
  void initState() {
    // List currListOfFavs =
    //     Provider.of<ItemStore>(context, listen: false).favourites;
    // isFav = isAFav(widget.item, currListOfFavs);
    Future.delayed(const Duration(seconds: 5));
    super.initState();
  }

  int getPricePerDay(noOfDays) {
    String country = Provider.of<ItemStore>(context, listen: false).renter.settings[0];
    
    int oneDayPrice = widget.item.rentPrice;

    if (country == 'BANGKOK') {
      oneDayPrice = widget.item.rentPrice;
    } else {
      oneDayPrice = int.parse(convertFromTHB(widget.item.rentPrice, country));
    }

    if (noOfDays == 3) {
      int threeDayPrice = (oneDayPrice * 0.8).toInt()-1;
      if (country == 'BANGKOK') {
        return (threeDayPrice ~/ 100) * 100 + 100;
      } else {
        return (threeDayPrice ~/ 5) * 5 + 5;
      }
    }
    if (noOfDays == 5) {
      int fiveDayPrice = (oneDayPrice * 0.6).toInt()-1;
      if (country == 'BANGKOK') {
        return (fiveDayPrice ~/ 100) * 100 + 100;
      } else {
        return (fiveDayPrice ~/ 5) * 5 + 5;
      }
    }
    return oneDayPrice;
  }

  void setPrice() {
    if (Provider.of<ItemStore>(context, listen: false).renter.settings[0] !=
        'BANGKOK') {
      String country = Provider.of<ItemStore>(context, listen: false).renter.settings[0];
      convertedRentPrice = getPricePerDay(5).toString();
      convertedBuyPrice = convertFromTHB(widget.item.buyPrice, country);
      convertedRRPPrice = convertFromTHB(widget.item.rrp, country);
      symbol = getCurrencySymbol(country);
    } else {
      convertedRentPrice = getPricePerDay(5).toString();
      convertedBuyPrice = widget.item.buyPrice.toString();
      convertedRRPPrice = widget.item.rrp.toString();
      symbol = globals.thb;
    }
  }

  String getSize(sizeArray) {
    String formattedSize = 'N/A';
    if (sizeArray.length == 1) {
      formattedSize = sizeArray.first;
    }
    if (sizeArray.length == 2) {
      String firstSize;
      String secondSize;
      firstSize = sizeArray.elementAt(0);
      secondSize = sizeArray.elementAt(1);
       formattedSize = '$firstSize-$secondSize';
    }
    return formattedSize;
  }

  Image thisImage = Image.asset('assets/img/items2/No_Image_Available.jpg');
Widget createImage(String imageName) {
  // final ref = FirebaseStorage.instance.ref().child('testimage');
  // var url = await ref.getDownloadURL();
  // log('URL $url');
  // return Image.network(url);
  if (myImage == null) log("creating image as myImage is null");
  return Image.asset(imageName,
      errorBuilder: (context, object, stacktrace) =>
          Image.asset('assets/img/items2/No_Image_Available.jpg'));
}
  @override
  Widget build(BuildContext context) {
    // List<ItemImage> cardImage = widget.item.imageId;

    log('Length of images is: ${Provider.of<ItemStore>(context, listen: false).images.length}');
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      log(i.id);
    }
    // TODO: fix this
    log('${Provider.of<ItemStore>(context, listen: false).images[0].id}');
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      log('ItemImage i is ${i.id} and widget has first element ${widget.item.imageId[0]}');
      if (i.id == widget.item.imageId[0]) {
        log('FOUND AN IMAGE MATCH');
        setState(() {
          // thisImage = Image.asset('assets/img/items2/AJE_Breathless_Frill_Sleeves_Dress_1.jpg');
          thisImage = i.imageId;
        }
        );
      }
    }
    double width = MediaQuery.of(context).size.width;
    List currListOfFavs =
        Provider.of<ItemStore>(context, listen: false).favourites;
    List currListOfFits =
        Provider.of<ItemStore>(context, listen: false).fittings;
    isFav = isAFav(widget.item, currListOfFavs);
    isFit = isAFit(widget.item.id, currListOfFits);
    setPrice();
    return Card(
      
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            if (!widget.isDesigner) Center(child: StyledHeading(widget.item.brand)),
            SizedBox(height: width * 0.02),
            // Image.asset('assets/img/items2/${setItemImage()}', width: 200, height: 600),
            Expanded(child: Center(
              // child: (Provider.of<ItemStore>(context, listen: false).images == null) ? createImage('assets/img/items2/${setItemImage()}')
              // : Provider.of<ItemStore>(context, listen: false).images[0]
              // child: (cardImage.imageId == null) ? createImage('assets/img/items2/${setItemImage()}')
              // : cardImage.imageId
              child: thisImage
            ),
            ),
            // Image.asset('assets/img/items2/${setItemImage()}', fit: BoxFit.fill),
            Row(
              // mainAxisAlignment: MainAxisAlignment.left,
              children: [
                 SizedBox(
                  width: width * 0.3,
                  height: width * 0.15,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: StyledHeading(widget.item.name))),
                const Expanded(child: SizedBox()),
                if (widget.item.status != 'submitted ') if (!widget.isFittingScreen) (isFav) ? IconButton(
                // (widget.item.status != 'submission') (!widget.isFittingScreen) (isFav) ? IconButton(
                  icon: Icon(Icons.favorite, size: width*0.05), color: Colors.red,
                  onPressed: () {
                      _toggleFav();
                      Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                      toSave.favourites.remove(widget.item.id);
                      Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                      Provider.of<ItemStore>(context, listen: false).removeFavourite(widget.item);

                  }) : 
                  IconButton(
                    icon: Icon(Icons.favorite_border_outlined, size: width*0.05),
                    onPressed: () {
                      _toggleFav();
                      Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                      toSave.favourites.add(widget.item.id);
                      Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                      Provider.of<ItemStore>(context, listen: false).addFavourite(widget.item);
                    }
                  ),
                if (widget.isFittingScreen) (isFit) ? IconButton(
                  icon: Icon(Icons.remove_circle_outline, size: width*0.05), color: Colors.red,
                  onPressed: () {
                      _toggleFit();
                      Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                      toSave.fittings.remove(widget.item.id);
                      Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                      Provider.of<ItemStore>(context, listen: false).removeFitting(widget.item.id);
                  }) : 
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, size: width*0.05, color: Colors.green),
                    onPressed: () {
                      if (Provider.of<ItemStore>(context, listen: false).renter.fittings.length < 6) {
                        _toggleFit();
                        Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                        toSave.fittings.add(widget.item.id);
                        Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                        Provider.of<ItemStore>(context, listen: false).addFitting(widget.item.id);
                      } else {
                        showAlertDialog(context);
                      }
                    }
                  )
                  
              ],
            ),
            // StyledBody('Size UK ${widget.item.size.toString()}', weight: FontWeight.normal),
            StyledBody('Size UK ${getSize(widget.item.size)}', weight: FontWeight.normal),
            // StyledText('Size: ${item.size.toString()}'),
            // int convertedRentPrice = convertFromTHB(${widget.item.rentPrice}, 'SGD');
            if (widget.item.bookingType == 'both' || widget.item.bookingType == 'rental') StyledBody('Rent from $convertedRentPrice$symbol per day', weight: FontWeight.normal),
            if (widget.item.bookingType == 'both' || widget.item.bookingType == 'buy') StyledBody('Buy for $convertedBuyPrice$symbol', weight: FontWeight.normal),
            StyledBodyStrikeout('RRP $convertedRRPPrice$symbol', weight: FontWeight.normal),
          ],
        ),
      ),
    );
  }
   showAlertDialog(BuildContext context) {
    // Create button
    double width = MediaQuery.of(context).size.width;

    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(-1.0),
        ),
        side: const BorderSide(width: 0.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: StyledBody("OK", color: Colors.white)),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: StyledHeading('MAXIMUM REACHED')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('Maximum number of dresses',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('is 6 for a fitting',
                    weight: FontWeight.normal),
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
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
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