import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/screens/profile/country_selector.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

late Container flag;

class _SettingsState extends State<Settings> {

List<Text> lengths = <Text>[
  const Text('CM'),
  const Text('INCH')
];
List<Text> heights = <Text>[
  const Text('CM'),
  const Text('FT')
];
List<Text> weights = <Text>[
  const Text('KG'),
  const Text('LBS')
];
  bool editingMode = false;




    List<bool> selectedLength = <bool>[true, false];
    List<bool> selectedHeight = <bool>[true, false];
    List<bool> selectedWeight = <bool>[true, false];

  void setEditingMode(editMode) {
                            setState(() {
                              log('Setting edit mode to $editMode');
    // editingMode = editMode;
                              // The button that is tapped is set to true, and the others to false.
                              editingMode = editMode;
                            });
  }

  @override
  void initState() {
    // TODO: implement initState
    String lengthMetric = Provider.of<ItemStore>(context, listen: false).renter.settings[1];
    String heightMetric = Provider.of<ItemStore>(context, listen: false).renter.settings[2];
    String weightMetric = Provider.of<ItemStore>(context, listen: false).renter.settings[3];
    if (lengthMetric == 'INCH') {
      selectedLength = [false, true];
    }
    if (heightMetric == 'FT') {
      selectedHeight = [false, true];
    }
    if (weightMetric == 'LBS') {
      selectedWeight = [false, true];
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    log("Building...");
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('SETTINGS'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ItemStore>(
        builder: (context, value, child) {
          String region = Provider.of<ItemStore>(context, listen: false).renter.settings[0];
          // log(Provider.of<ItemStore>(context, listen: false).renter.settings[0]);
          if (region == 'BANGKOK') {
            flag = Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Image.asset('icons/flags/png100px/th.png',
                  package: 'country_icons'),
            );
          } else {
            flag = Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Image.asset('icons/flags/png100px/sg.png',
                  package: 'country_icons'),
            );
          }
          return Padding(
            padding:
                EdgeInsets.fromLTRB(width * 0.05, width * 0.1, width * 0.05, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StyledHeading('MEASUREMENT UNITS', color: Colors.grey,
                    weight: FontWeight.normal),
                SizedBox(height: width * 0.02),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width * 0.03),
                        const StyledBody('LENGTH', weight: FontWeight.normal),
                        const Expanded(child: SizedBox()),
                        ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setState(() {
                              // The button that is tapped is set to true, and the others to false.
                              setEditingMode(true);
                              // editingMode = true;
                              for (int i = 0; i < selectedLength.length; i++) {
                                selectedLength[i] = i == index;
                              }
                            });
                          },
                          textStyle: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.bold),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                          selectedBorderColor: Colors.black,
                          selectedColor: Colors.black,
                          fillColor: Colors.grey[300],
                          color: Colors.grey,
                          constraints: BoxConstraints(
                            minHeight: width * 0.08,
                            minWidth: width * 0.16
                          ),
                          isSelected: selectedLength,
                          children: lengths,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                                Row(
                  children: [
                      SizedBox(width: width * 0.03),
                    const StyledBody('HEIGHT', weight: FontWeight.normal),
                    const Expanded(child: SizedBox()),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                              setEditingMode(true);
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < selectedHeight.length; i++) {
                            selectedHeight[i] = i == index;
                          }
                        });
                      },
                      textStyle: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.bold),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(0)),
                      selectedBorderColor: Colors.black,
                      selectedColor: Colors.black,
                      fillColor: Colors.grey[300],
                      color: Colors.grey,
                      constraints: BoxConstraints(
                        minHeight: width * 0.08,
                        minWidth: width * 0.16
                      ),
                      isSelected: selectedHeight,
                      children: heights,
                    ),
                  ],
                ),
                const Divider(),
                                Row(
                  children: [
                      SizedBox(width: width * 0.03),
                    const StyledBody('WEIGHT', weight: FontWeight.normal),
                    const Expanded(child: SizedBox(width: 100)),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                              setEditingMode(true);
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < selectedWeight.length; i++) {
                            selectedWeight[i] = i == index;
                          }
                        });
                      },
                      textStyle: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.bold),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(0)),
                      selectedBorderColor: Colors.black,
                      selectedColor: Colors.black,
                      fillColor: Colors.grey[300],
                      color: Colors.grey,
                      constraints: BoxConstraints(
                        minHeight: width * 0.08,
                        minWidth: width * 0.16
                      ),
                      isSelected: selectedWeight,
                      children: weights,
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(height: width * 0.1),
                const StyledHeading('COUNTRY', color: Colors.grey, weight: FontWeight.normal),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (CountrySelector(callback: setEditingMode))));
                  },
                  child: Row(
                    children: [
                      // Image.asset('icons/flags/png100/de.png', package: 'country_icons'),
                      // Image.asset('icons/flags/svg/de.svg', package: 'country_icons'),
                      SizedBox(width: width * 0.03),
                      SizedBox(
                        height: width * 0.04,
                        child: flag,
                      ),
                      SizedBox(width: width * 0.02),
                      StyledBody(region, weight: FontWeight.normal),
                    ],
                  ),
                ),
                const Divider(),
 
              ],
            ),
          );
        },
      ),
                bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (!editingMode) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('SAVE', weight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (editingMode) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                          log('SAVED PRESSED');
                          for (int i = 0; i < selectedLength.length; i++) {
                                  if (selectedLength[i] == true) {
                                  Renter toSave = Provider.of<ItemStore>(
                                          context,
                                          listen: false)
                                      .renter;
                                  log('Saving Length: ${lengths[i].data}');
                                  toSave.settings[1] = lengths[i].data;
                                  Provider.of<ItemStore>(context, listen: false)
                                      .saveRenter(toSave);
                                  }
                          }
                          for (int i = 0; i < selectedHeight.length; i++) {
                                  if (selectedHeight[i] == true) {
                                  Renter toSave = Provider.of<ItemStore>(
                                          context,
                                          listen: false)
                                      .renter;
                                  log('Saving Height: ${heights[i].data}');
                                  toSave.settings[2] = heights[i].data;
                                  Provider.of<ItemStore>(context, listen: false)
                                      .saveRenter(toSave);
                                  }
                          }
                          for (int i = 0; i < selectedWeight.length; i++) {
                                  log('Weight values are: ${selectedWeight[i].toString()}');
                                  if (selectedWeight[i] == true) {
                                  Renter toSave = Provider.of<ItemStore>(
                                          context,
                                          listen: false)
                                      .renter;
                                  log('Saving Weight: ${weights[i].data}');
                                  toSave.settings[3] = weights[i].data;
                                  Provider.of<ItemStore>(context, listen: false)
                                      .saveRenter(toSave);
                                  }
                          }
                                  Renter toSave = Provider.of<ItemStore>(
                                          context,
                                          listen: false)
                                      .renter;
                                  toSave.settings[0] = Provider.of<ItemStore>(context, listen: false).renter.settings[0];

                                  Provider.of<ItemStore>(context, listen: false)
                                      .saveRenter(toSave);
                    // setState(() {
                      // setEditingMode(false);
                    // });
                    setEditingMode(false);
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('SAVE', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }
}
