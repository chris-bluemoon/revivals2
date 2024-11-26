import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:revivals/shared/whatsapp.dart';


class VerifyId extends StatefulWidget {
  const VerifyId({super.key});

  @override
  State<VerifyId> createState() => _VerifyIdState();
}

class _VerifyIdState extends State<VerifyId> {
  

  late TextEditingController _addressController;
  late TextEditingController _phoneNumController;
  bool editingMode = false;

  String tempCountryField = '+66';

  @override
  void initState() {
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('ID VERIFICATION'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
      body: const Text('VERIFICATION')
    );
  }
}
