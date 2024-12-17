import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/sign_up/google_sign_in.dart';
import 'package:revivals/screens/summary/summary_rental.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/get_country_price.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class RentThisWithDateSelecter extends StatefulWidget {
  const RentThisWithDateSelecter(this.item, {super.key});

  final Item item;
  // final int rentalDays;

  @override
  State<RentThisWithDateSelecter> createState() =>
      _RentThisWithDateSelecterState();
}

class _RentThisWithDateSelecterState extends State<RentThisWithDateSelecter> {
  DateTime? startDate;
  DateTime? endDate;
  late int noOfDays = 0;
  // late int totalPrice = 0;
  bool bothDatesSelected = false;
  bool showConfirm = false;

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

  List<DateTime> getBlackoutDates(String itemId, int daysToRent) {
    //
    List<ItemRenter> itemRenters =
        Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<DateTime> tempList = [];

    for (int i = 0; i < itemRenters.length; i++) {
      
      DateTime startDate =
          DateFormat("yyyy-MM-dd").parse(itemRenters[i].startDate);
      DateTime endDate = DateFormat("yyyy-MM-dd").parse(itemRenters[i].endDate);
      String itemIdDB = itemRenters[i].itemId;
      if (itemIdDB == itemId) {
        for (int y = 0;
            y <=
                endDate
                    .difference(startDate.subtract(Duration(days: daysToRent)))
                    .inDays;
            y++) {
          tempList.add(startDate
              .subtract(Duration(days: daysToRent))
              .add(Duration(days: y)));
        }
      }
    }

    return tempList;
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2024, 8, 1),
    end: DateTime(2024, 9, 30),
  );

  // Future pickDateRange() async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //     context: context,
  //     initialDateRange: dateRange,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  //   if (newDateRange == null) return;
  //   setState(() => dateRange = newDateRange);
  // }

  DateRange selectedDateRange = DateRange(DateTime.now(), DateTime.now());

  int selectedOption = -1;
  String symbol = '?';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    String country = Provider.of<ItemStore>(context, listen: false).renter.settings[0];
    symbol = getCurrencySymbol(country);
       
        double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // StyledTitle(widget.item.name.toUpperCase()),
            StyledTitle('SELECT NO OF DAYS'),
            // Image.asset(
            //   'assets/logos/unearthed_logo_2.png',
            //   fit: BoxFit.contain,
            //   height: 200,
            // ),
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
        // bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(4.0),
        //     child: Container(
        //       color: Colors.grey[300],
        //       height: 1.0,
        //     )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40,10,40,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const Text('RENTAL TERM', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 30),
            if (Provider.of<ItemStore>(context, listen: false).renter.settings[0] == 'BANGKOK') ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -3),
                title: StyledHeading('1 Day (${(getPricePerDay(1))}$symbol per day)', weight: FontWeight.normal),
                trailing: Radio<int>(
                    value: 0,
                    groupValue: selectedOption,
                    // fillColor: Colors.black,
                    onChanged: (value) async {
                                          setState(() {
                        selectedOption = value!;
                      });
                      noOfDays = 1;
                      final DateTime? pickedDate = await showDatePicker(
                              currentDate: DateTime.utc(1989, 11, 9),
                              builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // TODO: Not working to change texttheme to increase fontsize
            textTheme: const TextTheme(
              // headlineSmall: TextStyle(fontSize: 20),
              // headlineMedium: TextStyle(fontSize: 20),
              // headlineLarge: TextStyle(fontSize: 20),
              // labelSmall: TextStyle(fontSize: 40),
              // labelMedium: TextStyle(fontSize: 40),
              labelLarge: TextStyle(fontSize: 20),
              // displaySmall: TextStyle(fontSize: 80),
              // displayMedium: TextStyle(fontSize: 80),
              // displayLarge: TextStyle(fontSize: 80),
              titleSmall: TextStyle(fontSize: 20),
              // titleMedium: TextStyle(fontSize: 80),
              // titleLarge: TextStyle(fontSize: 80),
              // bodySmall: TextStyle(fontSize: 80),
              // bodyMedium: TextStyle(fontSize: 80),
              // bodyLarge: TextStyle(fontSize: 80),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.white),
                      ),
            ),
          ),
          child: child!,
        );
      },
                        helpText: 'SELECT START DATE',
                        context: context,
                        // initialDate: DateTime.now(),
                        // initialDate: DateTime(2024, 8, 25),
                        // initialDate: DateTime.now().add(const Duration(days: -100)),
                        // firstDate: DateTime.now().add(const Duration(days: -1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                        selectableDayPredicate: (DateTime day) =>
                            !getBlackoutDates(
                                    widget.item.id, noOfDays)
                                .contains(day),
                        // day.isAfter(DateTime.now()),
                      );
        
        
        
                      if (pickedDate != null) {
                        setState(() {
                          startDate = pickedDate;
                          endDate = pickedDate
                              .add(Duration(days: noOfDays));
                         
                         
                         
                         
                         
                          selectedOption = -1;
                          showConfirm = true;
                          bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
                          loggedIn ? Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => (SummaryRental(widget.item, startDate!, endDate!, noOfDays, getPricePerDay(noOfDays)*noOfDays, 'booked', symbol))
                          )) : Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
                          // bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
                          // loggedIn ? Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) => (SummaryRental(widget.item, startDate!, endDate!, noOfDays, totalPrice(noOfDays)))
                          // )) : Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
        
                        });
                      } else {
                        setState(() {selectedOption = -1;});
                      }
                    })),
                        ListTile(
              dense: false,
              visualDensity: const VisualDensity(vertical: -3),
              title: StyledHeading('3 Days (${getPricePerDay(3)}$symbol per day)', weight: FontWeight.normal),
              trailing: Radio<int>(
                value: 1,
                groupValue: selectedOption,
                onChanged: (value3) async {
                  setState(() {
                    selectedOption = value3!;
                  });
                  noOfDays = 3;
                  final DateTime? pickedDate = await showDatePicker(
                    currentDate: DateTime.utc(1989, 11, 9),
                              builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // TODO: Not working to change texttheme to increase fontsize
            textTheme: const TextTheme(
              // headlineSmall: TextStyle(fontSize: 20),
              // headlineMedium: TextStyle(fontSize: 20),
              // headlineLarge: TextStyle(fontSize: 20),
              // labelSmall: TextStyle(fontSize: 40),
              // labelMedium: TextStyle(fontSize: 40),
              labelLarge: TextStyle(fontSize: 20),
              // displaySmall: TextStyle(fontSize: 80),
              // displayMedium: TextStyle(fontSize: 80),
              // displayLarge: TextStyle(fontSize: 80),
              titleSmall: TextStyle(fontSize: 20),
              // titleMedium: TextStyle(fontSize: 80),
              // titleLarge: TextStyle(fontSize: 80),
              // bodySmall: TextStyle(fontSize: 80),
              // bodyMedium: TextStyle(fontSize: 80),
              // bodyLarge: TextStyle(fontSize: 80),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.white),
                      ),
            ),
          ),
          child: child!,
        );
      },
                    helpText: 'SELECT START DATE',
                    context: context,
                    // initialDate: DateTime.now(),
                    // initialDate: DateTime(2024, 8, 25),
                    // initialDate: DateTime.now().add(const Duration(days: -100)),
                    // firstDate: DateTime.now().add(const Duration(days: -1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    selectableDayPredicate: (DateTime day) => !getBlackoutDates(
                            widget.item.id, noOfDays)
                        .contains(day),
                    // day.isAfter(DateTime.now()),
                  );
        
        
                  if (pickedDate != null) {
                    setState(() {
                      startDate = pickedDate;
                      endDate = pickedDate
                          .add(Duration(days: noOfDays));
                     
                     
                     
                     
                     
                      selectedOption = -1;
                      showConfirm = true;
                          bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
                          loggedIn ? Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => (SummaryRental(widget.item, startDate!, endDate!, noOfDays, getPricePerDay(noOfDays)*noOfDays, 'booked', symbol))
                          )) : Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
                    });
                  } else {
                    setState(() {selectedOption = -1;});
                  }
                  // if (pickedDate == null) {
                  //   return;
                  // } else {
                  //  setState(() {
                  //   newDate = pickedDate;
                  //  
                  //  });
                  // }
                },
              ),
            ),
            ListTile(
              dense: false,
              visualDensity: const VisualDensity(vertical: -3),
              title: StyledHeading('5 Days (${getPricePerDay(5)}$symbol per day)', weight: FontWeight.normal),
              trailing: Radio<int>(
                value: 2,
                groupValue: selectedOption,
                onChanged: (value3) async {
                  setState(() {
                    selectedOption = value3!;
                  });
                  noOfDays = 5;
                  final DateTime? pickedDate = await showDatePicker(
                    currentDate: DateTime.utc(1989, 11, 9),
                              builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // TODO: Not working to change texttheme to increase fontsize
            textTheme: const TextTheme(
              // headlineSmall: TextStyle(fontSize: 20),
              // headlineMedium: TextStyle(fontSize: 20),
              // headlineLarge: TextStyle(fontSize: 20),
              // labelSmall: TextStyle(fontSize: 40),
              // labelMedium: TextStyle(fontSize: 40),
              labelLarge: TextStyle(fontSize: 20),
              // displaySmall: TextStyle(fontSize: 80),
              // displayMedium: TextStyle(fontSize: 80),
              // displayLarge: TextStyle(fontSize: 80),
              titleSmall: TextStyle(fontSize: 20),
              // titleMedium: TextStyle(fontSize: 80),
              // titleLarge: TextStyle(fontSize: 80),
              // bodySmall: TextStyle(fontSize: 80),
              // bodyMedium: TextStyle(fontSize: 80),
              // bodyLarge: TextStyle(fontSize: 80),
            ),
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.white),
                      ),
            ),
          ),
          child: child!,
        );
      },
                    helpText: 'SELECT START DATE',
                    context: context,
                    // initialDate: DateTime.now(),
                    // initialDate: DateTime(2024, 8, 25),
                    // initialDate: DateTime.now().add(const Duration(days: -100)),
                    // firstDate: DateTime.now().add(const Duration(days: -1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    selectableDayPredicate: (DateTime day) => !getBlackoutDates(
                            widget.item.id, noOfDays)
                        .contains(day),
                    // day.isAfter(DateTime.now()),
                  );
        
        
                  if (pickedDate != null) {
                    setState(() {
                      startDate = pickedDate;
                      endDate = pickedDate
                          .add(Duration(days: noOfDays));
                     
                     
                     
                     
                     
                      selectedOption = -1;
                      showConfirm = true;
                          bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
                          loggedIn ? Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => (SummaryRental(widget.item, startDate!, endDate!, noOfDays, getPricePerDay(noOfDays)*noOfDays, 'booked', symbol))
                          )) : Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
                    });
                  } else {
                    setState(() {selectedOption = -1;});
                  }  
                  // if (pickedDate == null) {
                  //   return;
                  // } else {
                  //  setState(() {
                  //   newDate = pickedDate;
                  //  
                  //  });
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
