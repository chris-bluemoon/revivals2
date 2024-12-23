import 'package:flutter/material.dart';
import 'package:revivals/screens/profile/verify/my_verify_admin_list.dart';
import 'package:revivals/shared/styled_text.dart';

class AdminVerifyIds extends StatefulWidget {
  const AdminVerifyIds({super.key});

  @override
  State<AdminVerifyIds> createState() => _AdminVerifyIdsState();
}

class _AdminVerifyIdsState extends State<AdminVerifyIds> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.2,
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: width*0.03),
            tabs: const [
              Tab(text: 'PENDING IDS'),
              Tab(text: 'UNVERFIED IDS'),
              Tab(text: 'VERIFIED IDS')
            ],
          ),
          title: const StyledTitle('ID ADMIN CHECK'),
                      leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ),
        body: const TabBarView(
            children: [
              MyVerifyAdminList('pending'),
              MyVerifyAdminList('not started'),
              MyVerifyAdminList('verified'),
            ],
          ),
        ),
      );
  }
}
