import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/my_purchases_admin_bookings_list.dart';
import 'package:revivals/screens/profile/my_rentals_admin_bookings_list.dart';
import 'package:revivals/shared/styled_text.dart';

class AdminBookings extends StatefulWidget {
  const AdminBookings({super.key});

  @override
  State<AdminBookings> createState() => _AdminBookingsState();
}

class _AdminBookingsState extends State<AdminBookings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.2,
          bottom: TabBar(
            // indicatorColor: Colors.black,
            // labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: width*0.03),
            tabs: const [
              Tab(text: 'RENTALS'),
              Tab(text: 'PURCHASES'),
            ],
          ),
          title: const StyledTitle('ADMIN CHECK'),
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
        body: const TabBarView(
            children: [
              MyRentalsAdminBookingsList(),
              MyPurchasesAdminBookingsList(),
            ],
          )
        ),
      );
  }
}
