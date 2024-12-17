import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/profile/my_transactions_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyPurchasesAdminBookingsList extends StatefulWidget {
  const MyPurchasesAdminBookingsList({super.key});

  @override
  State<MyPurchasesAdminBookingsList> createState() => _MyPurchasesAdminBookingsListState();
}

class _MyPurchasesAdminBookingsListState extends State<MyPurchasesAdminBookingsList> {
  

  List<ItemRenter> myPurchasesList = [];
  List<Item> myItems = [];

  @override
  void initState() {
    loadMyPurchasesAdminBookingsList();
    super.initState();
  }
  
  void loadMyPurchasesAdminBookingsList() {
   
    // get current user
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    //
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<ItemRenter> allItemRenters = List.from(Provider.of<ItemStore>(context, listen: false).itemRenters);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    for (ItemRenter dr in allItemRenters) {
      if (dr.renterId == userEmail) {
        if (dr.transactionType == 'purchase') {
          myPurchasesList.add(dr);
        }
        // for (Item d in allItems) {
        //   if (d.id == dr.itemId) {
        //     myItems.add(d);
        //   }
        // }
      }
    }
    if (myPurchasesList.isEmpty) {
     
    }
    myPurchasesList.sort((a, b) => a.startDate.compareTo(b.startDate));
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
          itemCount: myPurchasesList.length,
          itemBuilder: (BuildContext context, int index) {
            // return MyPurchasesAdminImageWidget(myPurchasesList[index].itemId, myPurchasesList[index].startDate, myPurchasesList[index].endDate, myPurchasesList[index].price);
            return MyTransactionsAdminImageWidget(myPurchasesList[index], myPurchasesList[index].itemId, myPurchasesList[index].startDate, myPurchasesList[index].endDate, myPurchasesList[index].price, myPurchasesList[index].status);
        }
        );}
      );

  }}