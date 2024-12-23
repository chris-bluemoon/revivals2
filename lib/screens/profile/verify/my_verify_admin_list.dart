import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/screens/profile/verify/my_verify_admin_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyVerifyAdminList extends StatefulWidget {
  const MyVerifyAdminList(this.status, {super.key});

  final String status;

  @override
  State<MyVerifyAdminList> createState() => _MyVerifyAdminListState();
}

class _MyVerifyAdminListState extends State<MyVerifyAdminList> {
  

  List<Renter> myVerifyList = [];
  // List<Item> myItems = [];

  @override
  void initState() {
    log('initState MyVerifyAdminList');
    loadMyVerifyAdminList();
    super.initState();
  }
  
  void loadMyVerifyAdminList() {
   
    List<Renter> allRenters = List.from(Provider.of<ItemStore>(context, listen: false).renters);
    for (Renter r in allRenters) {
      if (r.verified == widget.status) {
          myVerifyList.add(r);
      }
    }
    if (myVerifyList.isEmpty) {
      log('Verify List is Empty');
    }
    log('VERIFY LIST IS SIZE ${myVerifyList.length}');
    // myVerifyList.sort((a, b) => a.startDate.compareTo(b.startDate));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<ItemStore>(
          builder: (context, value, child) {
      return ListView.builder(
        padding: EdgeInsets.all(width*0.01),
        itemCount: myVerifyList.length,
        itemBuilder: (BuildContext context, int index) {
          return MyVerifyAdminImageWidget(myVerifyList[index]);
      }
    );});

  }}