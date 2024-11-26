import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/profile/my_transactions_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyRentalsAdminBookingsList extends StatefulWidget {
  const MyRentalsAdminBookingsList({super.key});

  @override
  State<MyRentalsAdminBookingsList> createState() => _MyRentalsAdminBookingsListState();
}

class _MyRentalsAdminBookingsListState extends State<MyRentalsAdminBookingsList> {
  

  List<ItemRenter> myRentalsList = [];
  List<Item> myItems = [];

  @override
  void initState() {
    loadMyRentalsAdminBookingsList();
    super.initState();
  }
  
  void loadMyRentalsAdminBookingsList() {
    log('Loading loadMyRentalsAdminBookingsList');
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    List<ItemRenter> allItemRenters = List.from(Provider.of<ItemStore>(context, listen: false).itemRenters);
    for (ItemRenter dr in allItemRenters) {
      if (dr.renterId == userEmail) {
        if (dr.transactionType == 'rental') {
          myRentalsList.add(dr);
          log('Rented: ${dr.itemId}');
        }
      }
    }
    if (myRentalsList.isEmpty) {
      log('You have no rentals!');
    }
    myRentalsList.sort((a, b) => a.startDate.compareTo(b.startDate));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<ItemStore>(
          builder: (context, value, child) {
      return ListView.builder(
        padding: EdgeInsets.all(width*0.01),
        itemCount: myRentalsList.length,
        itemBuilder: (BuildContext context, int index) {
          return MyTransactionsAdminImageWidget(myRentalsList[index], myRentalsList[index].itemId, myRentalsList[index].startDate, myRentalsList[index].endDate, myRentalsList[index].price, myRentalsList[index].status);
      }
    );});

  }}