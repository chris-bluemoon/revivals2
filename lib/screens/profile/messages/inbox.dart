import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/message.dart';
import 'package:revivals/screens/profile/messages/my_message.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';

class MyMessages extends StatefulWidget {
  const MyMessages({super.key});

  @override
  State<MyMessages> createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {
  List<Message> myMessages = [];
  List<Item> myItems = [];

  bool isDateSentToday = false;

  @override
  void initState() {
    super.initState();
  }

  getMyMessages() {
    myMessages.clear();
   
    for (Message i in Provider.of<ItemStore>(context, listen: false).messages) {
     
     
      if (i.to == Provider.of<ItemStore>(context, listen: false).renter.name &&
          i.status != 'deleted') {
        myMessages.add(i);
       
      }
    }
    myMessages.sort((a, b) => b.dateSent.compareTo(a.dateSent));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // String address = Provider.of<ItemStore>(context, listen: false).renters[0].address;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: width * 0.2,
          // centerTitle: true,
          title: const StyledTitle('INBOX'),
        ),
        // TODO, is the valuelistener required?
        body: Consumer<ItemStore>(
            builder: (context, value, child) {
          getMyMessages();
          return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: myMessages.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: [
                      StyledBody(myMessages[index].author),
                      SizedBox(width: width * 0.1),
                      StyledBody(
                        DateFormat('d MMM, y HH:mm')
                            .format(DateTime.parse(myMessages[index].dateSent)),
                        weight: FontWeight.normal,
                      )
                    ],
                  ),
                  subtitle: StyledBody(
                    myMessages[index].subject,
                    weight: FontWeight.normal,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              (MyMessage(myMessages[index]))));
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: width * 0.05),
                  ),
                  // shape: RoundedRectangleBorder(
                  //   side: const BorderSide(color: Colors.black, width: 1),
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                );
              });
        }));
  }
}
