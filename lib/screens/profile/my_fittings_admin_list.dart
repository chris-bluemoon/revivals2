import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/profile/my_fittings_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyFittingsAdminList extends StatefulWidget {
  const MyFittingsAdminList({super.key});

  @override
  State<MyFittingsAdminList> createState() => _MyFittingsAdminListState();
}

class _MyFittingsAdminListState extends State<MyFittingsAdminList> {
  

  List<FittingRenter> myFittingsList = [];
  List<Item> myItems = [];

  @override
  void initState() {
    loadMyFittingsAdminList();
    super.initState();
  }
  
  void loadMyFittingsAdminList() {
    log('Loading loadMyFittingsAdminList');
    // get current user
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    // log('User email: $userEmail');
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<FittingRenter> allFittingRenters = List.from(Provider.of<ItemStore>(context, listen: false).fittingRenters);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    for (FittingRenter dr in allFittingRenters) {
      if (dr.renterId == userEmail) {
          myFittingsList.add(dr);
      }
    }
    if (myFittingsList.isEmpty) {
      log('You have no fittings!');
    }
    myFittingsList.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
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
          itemCount: myFittingsList.length,
          itemBuilder: (BuildContext context, int index) {
            // return MyPurchasesAdminImageWidget(myPurchasesList[index].itemId, myPurchasesList[index].startDate, myPurchasesList[index].endDate, myPurchasesList[index].price);
            return MyFittingsAdminImageWidget(myFittingsList[index], myFittingsList[index].bookingDate, myFittingsList[index].price, myFittingsList[index].status);
        }
        );}
      );

  }}