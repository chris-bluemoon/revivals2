import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/screens/profile/accounts/accounts_history_image_widget.dart';
import 'package:revivals/screens/profile/accounts/ledger_entry_widget.dart';
import 'package:revivals/screens/profile/my_fittings_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class AccountsHistoryList extends StatefulWidget {
  const AccountsHistoryList({super.key});

  @override
  State<AccountsHistoryList> createState() => _AccountsHistoryListState();
}

class _AccountsHistoryListState extends State<AccountsHistoryList> {
  

  List<ItemRenter> myItemRenters = [];
  List<Item> myItems = [];

  @override
  void initState() {
    loadAccountsHistoryList();
    super.initState();
  }
  
  void loadAccountsHistoryList() {
    String userEmail = Provider.of<ItemStore>(context, listen: false).renter.email;
    List<ItemRenter> allItemRenters = List.from(Provider.of<ItemStore>(context, listen: false).itemRenters);
    for (ItemRenter ir in allItemRenters) {
      if (ir.ownerId == userEmail) {
          log('Added ir');
          myItemRenters.add(ir);
      }
    }
    myItemRenters.sort((a, b) => a.endDate.compareTo(b.endDate));
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
          itemCount: myItemRenters.length,
          itemBuilder: (BuildContext context, int index) {
            // return MyPurchasesAdminImageWidget(myPurchasesList[index].itemId, myPurchasesList[index].startDate, myPurchasesList[index].endDate, myPurchasesList[index].price);
            return LedgerEntryWidget(myItemRenters[index]);
            // return AccountsHistoryImageWidget(myFittingsList[index], myFittingsList[index].bookingDate, myFittingsList[index].price, myFittingsList[index].status);
        }
        );}
      );

  }}