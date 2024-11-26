import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/screens/profile/my_fittings_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyUpcomingFittingsList extends StatefulWidget {
  const MyUpcomingFittingsList({super.key});

  @override
  State<MyUpcomingFittingsList> createState() => _MyUpcomingFittingsListState();
}

class _MyUpcomingFittingsListState extends State<MyUpcomingFittingsList> {
  

  List<FittingRenter> upcomingFittingsList = [];
  // List<Item> myItems = [];

  @override
  void initState() {
    loadMyUpcomingFittingsList();
    super.initState();
  }
  
  void loadMyUpcomingFittingsList() {
    // get current user
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    // log('User email: $userEmail');
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<FittingRenter> allFittingRenters = List.from(Provider.of<ItemStore>(context, listen: false).fittingRenters);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    log('Count of fittingRenters is ${allFittingRenters.length.toString()}');
    for (FittingRenter dr in allFittingRenters) {
      DateTime convertedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dr.bookingDate) ;
      if (dr.renterId == userEmail && convertedDate.isAfter(DateTime.now()) && dr.status != 'cancelled') {
          upcomingFittingsList.add(dr);
          log('Rented: ${dr.renterId}');
        }
      }
    if (upcomingFittingsList.isEmpty) {
      log('You have no fittings!');
    }
    upcomingFittingsList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // String address = Provider.of<ItemStore>(context, listen: false).renters[0].address;
    return 
      Consumer<ItemStore>(
        builder: (context, value, child) {
        return ListView.builder(
          padding: EdgeInsets.all(width*0.01),
          itemCount: upcomingFittingsList.length,
          itemBuilder: (BuildContext context, int index) {
            return (upcomingFittingsList.isNotEmpty) ? MyUpcomingFittingsImageWidget(upcomingFittingsList[index], upcomingFittingsList[index].itemArray, upcomingFittingsList[index].bookingDate, upcomingFittingsList[index].price, upcomingFittingsList[index].status)
              : const Text('NO BOOKINGS');
        });
        }
      );

  }}