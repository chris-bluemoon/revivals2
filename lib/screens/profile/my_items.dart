import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/my_items_list.dart';
import 'package:revivals/shared/styled_text.dart';

class MyItems extends StatelessWidget {
  const MyItems({super.key});

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
              Tab(text: 'DRESSES'),
              Tab(text: 'BAGS'),
            ],
          ),
          title: const StyledTitle('MY ITEMS'),
          leading: IconButton(
            icon: Icon(Icons.home_outlined, size: width*0.06),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
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
            Text('DUMMY1'),
            MyItemsList(),
          ],
        ),
      ),
    );
  }
}
