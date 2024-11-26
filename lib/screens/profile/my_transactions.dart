import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/my_purchases_list.dart';
import 'package:revivals/screens/profile/my_rentals_list.dart';
import 'package:revivals/shared/styled_text.dart';

class MyTransactions extends StatelessWidget {
  const MyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.2,
          // automaticallyImplyLeading: false,
          bottom: TabBar(
            // indicatorColor: Colors.black,
            // labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: width*0.03),
            tabs: const [
              Tab(text: 'RENTALS'),
              Tab(text: 'PURCHASES'),
            ],
          ),
          title: const StyledTitle('BOOKINGS'),
                      leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () =>
        //           {Navigator.of(context).popUntil((route) => route.isFirst)},
        //       icon: Icon(Icons.close, size: width*0.06)),
        // ],
        ),
        body:  const TabBarView(
          children: [
            MyRentalsList(),
            MyPurchasesList(),
          ],
        ),
      ),
    );
  }
}
