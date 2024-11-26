import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/my_fittings_admin_list.dart';
import 'package:revivals/shared/styled_text.dart';

class AdminFittings extends StatefulWidget {
  const AdminFittings({super.key});

  @override
  State<AdminFittings> createState() => _AdminFittingsState();
}

class _AdminFittingsState extends State<AdminFittings> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.2,
          bottom: TabBar(
            // indicatorColor: Colors.black,
            // labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: width*0.03),
            tabs: const [
              Tab(text: 'FITTINGS'),
            ],
          ),
          title: const StyledTitle('FITTING ADMIN CHECK'),
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
              MyFittingsAdminList(),
            ],
          )
        ),
      );
  }
}
