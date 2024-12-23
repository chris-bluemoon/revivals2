import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/profile/admin_bookings.dart';
import 'package:revivals/screens/profile/admin_fittings.dart';
import 'package:revivals/screens/profile/verify/admin_verifify_ids.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/item_results.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class MyAdmin extends StatefulWidget {
  const MyAdmin({super.key});

  @override
  State<MyAdmin> createState() => _MyAdminState();
}

class _MyAdminState extends State<MyAdmin> {
  
  @override
  void initState() {
    super.initState();
  }
    void handleItemsDelete() {
     
      Provider.of<ItemStore>(context, listen: false).deleteItems();
    }
      void handleItemRentersDelete() {
      Provider.of<ItemStore>(context, listen: false).deleteItemRenters();
    }
    void handleFittingDelete() {
      Provider.of<ItemStore>(context, listen: false).deleteFittingRenters();
    }
    void handleSubmit() {
    
    for (var i = 0; i < allItems.length; i++) {
     
      Provider.of<ItemStore>(context, listen: false).addItem(Item(
        id: uuid.v4(),
        owner: allItems[i].owner,
        type: allItems[i].type,
        bookingType: allItems[i].bookingType,
        occasion: allItems[i].occasion,
        dateAdded: allItems[i].dateAdded,
        style: allItems[i].style,
        name: allItems[i].name,
        brand: allItems[i].brand,
        colour: allItems[i].colour,
        size: allItems[i].size,
        length: allItems[i].length,
        print: allItems[i].print,
        sleeve: allItems[i].sleeve,
        rentPrice: allItems[i].rentPrice,
        buyPrice: allItems[i].buyPrice,
        rrp: allItems[i].rrp,
        description: allItems[i].description,
        bust: allItems[i].bust,
        waist: allItems[i].waist,
        hips: allItems[i].hips,
        longDescription: allItems[i].longDescription,
        imageId: allItems[i].imageId,
        status: 'submitted'
        // isFav: allItems[i].isFav,
    ));
    }

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('ADMIN'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
          child: Column(children: [
                  GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const AdminBookings())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN: CHECK ORDERS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('status', 'denied'))));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN: VIEW DENIED', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('status', 'submitted'))));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN: CHECK SUBMISSIONS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const AdminFittings())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN: CHECK FITTINGS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const AdminVerifyIds())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN: CHECK IDS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                const StyledTitle('LIVE DATABASE FUNCTIONS'),
                const SizedBox(height: 20),
                const StyledHeading('USE WITH EXTREME CARE', color: Colors.red),
                const StyledHeading('THIS AFFECTS THE LIVE APP', color: Colors.red),
                const SizedBox(height: 40),
                ElevatedButton (
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showAlertDialog(context, handleItemsDelete);
                  },
                  child: const Text('DELETE ITEMS'),
                ),
                const Divider(height: 20),
                ElevatedButton (
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showAlertDialog(context, handleSubmit);
                  },
                  child: const Text('ADD ITEMS'),
                ),
                const Divider(height: 20),
                ElevatedButton (
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    // showAlertDialog(context, handleDelete);
                    showAlertDialog(context, handleItemRentersDelete);
                    // handleDelete();
                  },
                  child: const Text('DELETE ITEMRENTERS'),
                ),
                const Divider(height: 20),
                ElevatedButton (
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showAlertDialog(context, handleFittingDelete);
                  },
                  child: const Text('DELETE FITTING RENTERS'),
                )
              ],
            )
        ),
      );
  }

  showAlertDialog(BuildContext context, Function f) {
    double width = MediaQuery.of(context).size.width;

    Widget cancelButton = Container(
      margin: const EdgeInsets.all(50),
      height: 100,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          foregroundColor: Colors.white, //change background color of button
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(-1.0),
          ),
          side: const BorderSide(width: 0.0, color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Center(child: StyledBody("CANCEL", color: Colors.white)),
      ),
    );
    Widget okButton = Container(
      margin: const EdgeInsets.all(50),
      height: 50,
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          foregroundColor: Colors.white, //change background color of button
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(-1.0),
          ),
          side: const BorderSide(width: 0.0, color: Colors.black),
        ),
        onPressed: () {
          f();
          Navigator.of(context).pop();
        },
        child: const Center(child: StyledBody("I'M SURE!", color: Colors.white)),
      ),
    );
    AlertDialog alert = AlertDialog(
      title: const Center(child: StyledHeading('WARNING!!!!')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('You are about to delete live data,',
                    weight: FontWeight.normal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('only use if you are SURE what you are doing',
                    weight: FontWeight.normal),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
        cancelButton
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
