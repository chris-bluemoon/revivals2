import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({required this.callback, super.key});

  final Function callback; 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: const StyledTitle('SETTINGS', weight: FontWeight.normal),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.01),
            const StyledHeading('Select Your Region'),
            SizedBox(height: width* 0.01),
            const StyledBody('Note: This may affect availability and pricing.', weight: FontWeight.normal,),
            SizedBox(height: width* 0.08),
            GestureDetector(
              onTap: () {
                Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
               
                toSave.settings[0] = 'BANGKOK';
                Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                // Provider.of<ItemStore>(context, listen: false).setRegion('BANGKOK');
                callback(true);
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, 0), 
                child: Image.asset('assets/img/backgrounds/bangkok_skyline.png'),
              ),
            ),
            SizedBox(height: width * 0.04),
            GestureDetector(
              onTap: () {
                Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                toSave.settings[0] = 'SINGAPORE';
               
                Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                // Provider.of<ItemStore>(context, listen: false).setRegion('SINGAPORE');
                callback(true);
                Navigator.pop(context);

              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, 0), 
                child: Image.asset('assets/img/backgrounds/singapore_skyline.png'),
              ),
            ),

          ],  
        ),
      )
    );
  }
}