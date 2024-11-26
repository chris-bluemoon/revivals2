import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/services/class_store.dart';

class ConfirmRentWidget extends StatefulWidget {
  const ConfirmRentWidget(this.item, {super.key});

  final Item item;

  @override
  State<ConfirmRentWidget> createState() => _ConfirmRentWidget();
}

class _ConfirmRentWidget extends State<ConfirmRentWidget> {
  @override
  Widget build(BuildContext context) {
    log('Logged in: ${Provider.of<ItemStore>(context, listen: false).loggedIn}');
    return Column(
      children: [
        // Text('Rent ${widget.item.name} for ${widget.item.rentPrice} Baht')
        Text('Rent for ${widget.item.rentPrice} Baht')
      ],
    );
  }
}