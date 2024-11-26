import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/my_history_fittings_list.dart';
import 'package:revivals/screens/profile/my_upcoming_fittings_list.dart';
import 'package:revivals/shared/styled_text.dart';

class MyFittings extends StatelessWidget {
  const MyFittings(this.isFromABooking, {super.key});

  final bool isFromABooking;

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
              Tab(text: 'UPCOMING'),
              Tab(text: 'HISTORY'),
            ],
          ),
          title: const StyledTitle('FITTING SESSIONS'),
                      leading: IconButton(
          icon: (isFromABooking) ? Container(
              padding: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
              child: Icon(Icons.home_outlined, size: width*0.06),
          ) 
            : Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            (isFromABooking) ? Navigator.of(context).popUntil((route) => route.isFirst)
              : Navigator.pop(context);
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
            MyUpcomingFittingsList(),
            MyHistoryFittingsList(),
          ],
        ),
      ),
    );
  }
}
