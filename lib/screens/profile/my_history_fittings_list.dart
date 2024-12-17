import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/screens/profile/my_history_fittings_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyHistoryFittingsList extends StatefulWidget {
  const MyHistoryFittingsList({super.key});

  @override
  State<MyHistoryFittingsList> createState() => _MyHistoryFittingsListState();
}

class _MyHistoryFittingsListState extends State<MyHistoryFittingsList> {
  

  List<FittingRenter> historyFittingsList = [];
  // List<Item> myItems = [];

  @override
  void initState() {
    loadMyHistoryFittingsList();
    super.initState();
  }
  
  void loadMyHistoryFittingsList() {
    // get current user
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<FittingRenter> allFittingRenters = List.from(Provider.of<ItemStore>(context, listen: false).fittingRenters);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    for (FittingRenter dr in allFittingRenters) {
      DateTime convertedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dr.bookingDate) ;
      if (dr.renterId == userEmail && convertedDate.isBefore(DateTime.now())) {
          historyFittingsList.add(dr);
        }
      }
    if (historyFittingsList.isEmpty) {
     
    }
    historyFittingsList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // String address = Provider.of<ItemStore>(context, listen: false).renters[0].address;
    return 
      ListView.builder(
        padding: EdgeInsets.all(width*0.01),
        itemCount: historyFittingsList.length,
        itemBuilder: (BuildContext context, int index) {
          return (historyFittingsList.isNotEmpty) ? MyHistoryFittingsImageWidget(historyFittingsList[index], historyFittingsList[index].itemArray, historyFittingsList[index].bookingDate, historyFittingsList[index].price, historyFittingsList[index].status)
            : const Text('NO BOOKINGS');
      }
          );

  }}