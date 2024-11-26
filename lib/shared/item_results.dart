import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluralize/pluralize.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/fitting/fitting.dart';
import 'package:revivals/screens/to_rent/to_rent.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/filters_page.dart';
import 'package:revivals/shared/item_card.dart';
import 'package:revivals/shared/no_items_found.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class ItemResults extends StatefulWidget {
  const ItemResults(this.attribute, this.value, {super.key});

  final String attribute;
  final String value;

  @override
  State<ItemResults> createState() => _ItemResultsState();
}

class _ItemResultsState extends State<ItemResults> {
  Badge myBadge = const Badge(child: Icon(Icons.filter));

  List<Item> filteredItems = [];

  late List<String> sizes = [];
  late RangeValues ranges = const RangeValues(0, 0);
  late List<String> lengths = [];
  late List<String> prints = [];
  late List<String> sleeves = [];
  late Set coloursSet = <String>{};
  late Set sizesSet = <String>{};
  late bool filterOn = false;
  late int numOfFilters = 0;
  
  void setValues(
      List<String> filterColours,
      List<String> filterSizes,
      RangeValues rangeValuesFilter,
      List<String> filterLengths,
      List<String> filterPrints,
      List<String> filterSleeves) {
    sizes = filterSizes;
    lengths = filterLengths;
    ranges = rangeValuesFilter;
    prints = filterPrints;
    sleeves = filterSleeves;
    coloursSet = {...filterColours};
    sizesSet = {...filterSizes};
    setState(() {});
  }

  void setFilter(bool filter, int noOfFilters) {
    filterOn = filter;
    numOfFilters = noOfFilters;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // getCurrentUser();
    List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    List<Item> finalItems = [];
    filteredItems.clear();
    log('Fittings count ${Provider.of<ItemStore>(context, listen: false).renter.fittings.length.toString()}');

    if (filterOn == true) {
      switch (widget.attribute) {
        case 'brand':
          for (Item i in allItems) {
            if (i.brand == widget.value) {
              filteredItems.add(i);
            }
          }
        case 'occasion':
          for (Item i in allItems) {
            if (i.occasion.contains(widget.value)) {
              filteredItems.add(i);
            }
          }
        case 'type':
          for (Item i in allItems) {
            if (i.type == widget.value) {
              filteredItems.add(i);
            }
          }
        case 'bookingType':
          for (Item i in allItems) {
            log('bookingType: ${i.bookingType}');
            if (i.bookingType == widget.value || i.bookingType == 'both') {
              filteredItems.add(i);
            }
          }
        case 'dateAdded':
          for (Item i in allItems) {
            DateFormat format = DateFormat("dd-MM-yyyy");
            DateTime dateSupplied = format.parse(widget.value);
            DateTime dateAdded = format.parse(i.dateAdded);
            if (dateAdded.isAfter(dateSupplied)) {
              filteredItems.add(i);
            }
          }
        case 'fitting':
          for (Item i in allItems) {
          log('Adding filtered item');
              filteredItems.add(i);
          }
      }
      for (Item i in filteredItems) {
        // if (i.filteredItems.contains(widget.value)
        Set colourSet = {...i.colour};
        Set sizeSet = {...i.size};
        if (lengths.contains(i.length.toString()) &&
            prints.contains(i.print.toString()) &&
            sleeves.contains(i.sleeve.toString()) &&
            coloursSet.intersection(colourSet).isNotEmpty &&
            sizesSet.intersection(sizeSet).isNotEmpty &&
            i.rentPrice > ranges.start &&
            i.rentPrice < ranges.end) {
              finalItems.add(i);
        }
      }
    } else {
      for (Item i in allItems) {
        switch (widget.attribute) {
          case 'brand':
            if (i.brand == widget.value) {
              finalItems.add(i);
          }
          case 'occasion':
            if (i.occasion.contains(widget.value)) {
              finalItems.add(i);
          }
          case 'type':
            if (i.type == widget.value) {
              finalItems.add(i);
          }
        case 'bookingType':
            if (i.bookingType == widget.value || i.bookingType == 'both') {
              finalItems.add(i);
            }
        case 'dateAdded':
          for (Item i in allItems) {
            DateFormat format = DateFormat("dd-MM-yyyy");
            DateTime dateSupplied = format.parse(widget.value);
            DateTime dateAdded = format.parse(i.dateAdded);
            if (dateAdded.isAfter(dateSupplied)) {
              finalItems.add(i);
            }
          }
        case 'fitting':
          finalItems.add(i);
        }
      }
    }
    bool itemsFound = false;
    if (finalItems.isEmpty) {
      itemsFound = false;
    } else {
      itemsFound = true;
    }
    String setTitle(attribute) {
      String title = 'TO SET';
      switch (attribute) {
        case 'dateAdded':  {
          title = 'LATEST ADDITIONS';
        }
        case 'brand':  {
          title = widget.value.toUpperCase();
        }
        case 'occasion':  {
          title = widget.value.toUpperCase();
        }
        case 'bookingType':  {
          title = Pluralize().plural(widget.value).toUpperCase();
        }
        case 'fitting':  {
          title = 'SELECT YOUR ITEMS';
        }
      }

      return title;
    }
    return Consumer<ItemStore>(
      builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: width * 0.2,
            title: StyledTitle(setTitle(widget.attribute)),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.chevron_left, size: width * 0.1),
              onPressed: () {
                Provider.of<ItemStore>(context, listen: false).resetFilters();
                Navigator.pop(context);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          (FiltersPage(setFilter: setFilter, setValues: setValues))));
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, width*0.0, width*0.03, 0),
                  child: (numOfFilters == 0) ? Image.asset('assets/img/icons/1.png', height: width * 0.1) :
                    (numOfFilters == 1) ? Image.asset('assets/img/icons/2.png', height: width * 0.1) :
                    (numOfFilters == 2 ) ? Image.asset('assets/img/icons/3.png', height: width * 0.1) :
                    (numOfFilters == 3 ) ? Image.asset('assets/img/icons/4.png', height: width * 0.1) :
                    (numOfFilters == 4 ) ? Image.asset('assets/img/icons/5.png', height: width * 0.1) :
                    (numOfFilters == 5 ) ? Image.asset('assets/img/icons/6.png', height: width * 0.1) :
                    (numOfFilters == 6 ) ? Image.asset('assets/img/icons/7.png', height: width * 0.1) :
                    Image.asset('assets/img/icons/1.png', width: width * 0.01)
                ),
              ),
            ],
          ),
          body: (itemsFound)
              ? Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Consumer<ItemStore>(
                          builder: (context, value, child) {
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.5),
                            itemBuilder: (_, index) => GestureDetector(
                                child: (widget.attribute == 'brand') ? ItemCard(finalItems[index], true, false) :
                                  (widget.attribute == 'fitting') ? ItemCard(finalItems[index], false, true) :
                                  ItemCard(finalItems[index], false, false),
                                onTap: () {
                                  if (widget.attribute != 'fitting') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          (ToRent(finalItems[index]))));
                                  }
                                }),
                            itemCount: finalItems.length,
                          ),
                        );
                      }),
                    ],
                  ))
              : const NoItemsFound(),
          floatingActionButton: (widget.attribute == 'fitting') ? FloatingActionButton(
                    onPressed: () {
                      if (Provider.of<ItemStore>(context, listen: false).renter.fittings.length != 0) {
                       Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                          (const Fitting())));
                      } else {
                          showAlertDialog(context);
                      }
                    },
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    child: Badge(
                      label: Text(Provider.of<ItemStore>(context, listen: false).renter.fittings.length.toString()),
                      largeSize: 20,
                      textStyle: const TextStyle(fontSize: 16),
                      child: const Icon(Icons.shopping_bag_outlined, size: 40),
                    )) : null);
      }
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
      title: const Center(child: StyledHeading('CHOOSE YOUR STYLE')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('Select at least 1 dress',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('before scheduling a fitting',
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

