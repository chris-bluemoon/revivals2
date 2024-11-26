import 'dart:developer';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/fitting/fitting_item_image.dart';
import 'package:revivals/screens/fitting/fitting_summary.dart';
import 'package:revivals/screens/profile/my_fittings.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/send_email2.dart';
import 'package:revivals/shared/styled_text.dart';

class Fitting extends StatefulWidget {
  const Fitting({super.key});

  @override
  State<Fitting> createState() => _FittingState();
}

class _FittingState extends State<Fitting> {
  List<String> fittingIds = [];
  List<Item> allItemsWithID = [];

  void handleSubmit(String renterId, List<String> itemArray, String bookingDate,
      int price, String status) {
    Provider.of<ItemStore>(context, listen: false)
        .addFittingRenter(FittingRenter(
      id: uuid.v4(),
      renterId: renterId,
      itemArray: itemArray,
      bookingDate: bookingDate,
      price: price,
      status: status,
    ));
  }

  // BC
  final now = DateTime.now();
  late BookingService mockBookingService;

  List<String> allNames = [];
  List<String> dressImages = [];
  late DateTime? pickedDate = DateTime.now();

  String setItemImage(itemId) {
    late Item i;
    late String imageName = '';
    for (i in allItemsWithID) {
      // log('Checking item ids ${i.id} == $itemId');
      if (i.id == itemId) {
        String itemType = toBeginningOfSentenceCase(i.type.replaceAll(RegExp(' +'), '_'));
        String itemName = i.name.replaceAll(RegExp(' +'), '_');
        String brandName = i.brand.replaceAll(RegExp(' +'), '_');
        imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
      }
    }
    // Item item = allItems.singleWhere((i) => i.id == itemId);
    return imageName;
  }

  String getDressNames() {
    List<String> allNames = [];

    for (Item dress in allItemsWithID) {
      for (String fittingId in fittingIds) {
        log('Checkign IDS $fittingId vs ${dress.id}');
        if (dress.id == fittingId) {
          log('Adding dress named ${dress.name}');
          allNames.add(dress.name);
        }
      }
    }

    return allNames.join(' - ');
  }

  @override
  void initState() {
    super.initState();
    // for (String i in Provider.of<ItemStore>(context, listen: false).fittings) {
    //   fittingIds.add(i);
    //   setItemImage(fittingIds);
    // }
    // for (Item i in allItems) {
      // allNames.add(i.name);
    // }
    // BC
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 60,
        bookingStart: DateTime(now.year, now.month, now.day, 10, 0),
        bookingEnd: DateTime(now.year, now.month, now.day, 20, 0));
  }

  // BC
  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
        var value;
        Stream.value([]).listen(value);
        log(value.toString());
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    // await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));

    String email = Provider.of<ItemStore>(context, listen: false).renter.email;
    String bookingDate = newBooking.toJson()['bookingStart'].toString();
    DateTime convertedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(bookingDate) ;
    String dateString1 = DateFormat('E, d MMMM y').format(convertedDate);
    String dateString2 = DateFormat('HH:ss').format(convertedDate);
    String uname = Provider.of<ItemStore>(context, listen: false).renter.name;
    handleSubmit(email, fittingIds, bookingDate, 100, 'booked');

    log('${newBooking.toJson()} has been uploaded');
    Provider.of<ItemStore>(context, listen: false).clearFittings();
    EmailComposer2(emailAddress: email, userName: uname, bookingDate: '$dateString1 at $dateString2', dresses: getDressNames()).sendFittingEmail();
    showAlertDialog(context);
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    converted.add(DateTimeRange(start: first, end: now.add(const Duration(minutes: 5))));
    for (FittingRenter fr in Provider.of<ItemStore>(context, listen: false).fittingRenters) {
      if (fr.status != 'cancelled') {
        DateTime startDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(fr.bookingDate);
        converted.add(DateTimeRange(start: startDate, end: startDate.add(const Duration(minutes: 59))));
      }
    }
    for (ItemRenter ir in Provider.of<ItemStore>(context, listen: false).itemRenters) {
      DateTime startDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(ir.startDate);
      DateTime endDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(ir.endDate);
      String itemId = ir.itemId;
      if (now.isBefore(startDate)) {
        if (Provider.of<ItemStore>(context, listen: false).fittings.contains(itemId)) {
          converted.add(DateTimeRange(start: startDate, end: endDate));
        }
      }

    }
    DateTime startTimeToBlock = DateFormat('HH:mm').parse('10:00');
    DateTime endTimeToBlock = now;
    converted.add(DateTimeRange(start: startTimeToBlock, end: endTimeToBlock)) ;
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  Map chosenItem = {};
  List<Map> chosenItems = [];

  Color containerColour = Colors.white;
  bool isSelected = false;

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    allItemsWithID = Provider.of<ItemStore>(context, listen: false).items;
    dressImages.clear();
    for (String i in Provider.of<ItemStore>(context, listen: false).fittings) {
      fittingIds.add(i);
      dressImages.add(setItemImage(i));
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledTitle('BOOK FITTING'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: width * 0.1),
            const StyledHeading('YOUR DRESS SELECTION'),
            SizedBox(height: width * 0.01),
            SizedBox(
              height: width * 0.3,
              // width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dressImages.length,
                itemBuilder: (context, index) {
                  // return Image.asset('assets/img/items2/${dressImages[index]}');
                  return FittingItemImage(dressImages[index]);
                },
              ),
            ),
            const SizedBox(height: 40),
            Divider(
              indent: width * 0.1,
              endIndent: width * 0.1,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                const StyledHeading('SELECT A DATE'),
              ],
            ),
            Center(
              child: Container(
                height: 450,
                child: Expanded(
                  child: BookingCalendar(
                    bookingButtonColor: Colors.black,
                    bookingService: mockBookingService,
                    convertStreamResultToDateTimeRanges: convertStreamResultMock,
                    getBookingStream: getBookingStreamMock,
                    uploadBooking: uploadBookingMock,
                    pauseSlots: const [],
                    pauseSlotText: 'LUNCH',
                    gridScrollPhysics: const NeverScrollableScrollPhysics(), 
                    hideBreakTime: true,
                    loadingWidget: const Text('Fetching data...'),
                    uploadingWidget: const CircularProgressIndicator(),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    wholeDayIsBookedWidget:
                    const StyledHeading('Sorry, for this day everything is booked'),
                    bookedSlotTextStyle: TextStyle(fontSize: width * 0.03),
                    availableSlotTextStyle: TextStyle(fontSize: width * 0.03),
                    selectedSlotTextStyle: TextStyle(fontSize: width * 0.03),
                    bookingGridCrossAxisCount: 4,
                    bookingGridChildAspectRatio: 1.5,
                  ),
                ),
              ),
            ),
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
          borderRadius: BorderRadius.circular(0.0),
        ),
        side: const BorderSide(width: 1.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const MyFittings(true))));
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
                (Provider.of<ItemStore>(context, listen: false).fittings.length > 1) ? const StyledBody("Your dresses being prepared,",
                    weight: FontWeight.normal) :
                    const StyledBody("Your dress is being prepared.", weight: FontWeight.normal)
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
