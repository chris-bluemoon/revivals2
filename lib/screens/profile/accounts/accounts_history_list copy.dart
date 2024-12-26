import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/profile/accounts/accounts_history_image_widget.dart';
import 'package:revivals/screens/profile/my_fittings_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class AccountsHistoryList extends StatefulWidget {
  const AccountsHistoryList({super.key});

  @override
  State<AccountsHistoryList> createState() => _AccountsHistoryListState();
}

class _AccountsHistoryListState extends State<AccountsHistoryList> {
  

  List<FittingRenter> myFittingsList = [];
  List<Item> myItems = [];

  @override
  void initState() {
    loadAccountsHistoryList();
    super.initState();
  }
  
  void loadAccountsHistoryList() {
   
    // get current user
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    //
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<FittingRenter> allFittingRenters = List.from(Provider.of<ItemStore>(context, listen: false).fittingRenters);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    for (FittingRenter dr in allFittingRenters) {
      if (dr.renterId == userEmail) {
          myFittingsList.add(dr);
      }
    }
    if (myFittingsList.isEmpty) {
     
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
            return AccountsHistoryImageWidget(myFittingsList[index], myFittingsList[index].bookingDate, myFittingsList[index].price, myFittingsList[index].status);
        }
        );}
      );

  }}