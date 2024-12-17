import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/profile/my_item_image_widget.dart';
import 'package:revivals/services/class_store.dart';


class MyItemsList extends StatefulWidget {
  const MyItemsList({super.key});

  @override
  State<MyItemsList> createState() => _MyItemsListState();
}

class _MyItemsListState extends State<MyItemsList> {
  

  List<Item> myItems = [];

  @override
  void initState() {
    loadMyItemsList();
    super.initState();
  }
  
  void loadMyItemsList() {
    // get current user
    String userId = Provider.of<ItemStore>(context, listen: false).renter.id;
    //
    // List<ItemRenter> myItemRenters = Provider.of<ItemStore>(context, listen: false).itemRenters;
    List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    // List<Item> allItems = List.from(Provider.of<ItemStore>(context, listen: false).items);
    for (Item i in allItems) {
      if (i.owner == userId) {
          myItems.add(i);
        }
      }
    if (myItems.isEmpty) {
     
    }
    // .sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
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
          itemCount: myItems.length,
          itemBuilder: (BuildContext context, int index) {
            return (myItems.isNotEmpty) ? MyItemImageWidget(myItems[index])
              : const Text('NO ITEMS');
        });
        }
      );

  }}