
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/message.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class UserPage extends StatefulWidget {
  const UserPage(this.owner, this.item, {super.key});

  final String owner;
  final Item item;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  
  @override
  void initState() {
    super.initState();
  }

  final messageController = TextEditingController();
  bool showSendButton = false;

  void checkContents(String text) {
    if (text.isEmpty) {
      setState(() {
        showSendButton = false;
      });
    } else {
      setState(() {
        showSendButton = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: StyledTitle(widget.owner),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
            StyledBody(widget.item.name),
            StyledBody('${widget.item.type}, UK ${widget.item.size}'),
            SizedBox(height: width * 0.03),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 300,
                    controller: messageController,
                    onChanged: (text) {
                      checkContents(text);
                    },
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(0),
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black)
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type your message",
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                if (showSendButton) IconButton(
                 padding: EdgeInsets.zero,
                 constraints: const BoxConstraints(), 
              onPressed: () {
                String author = Provider.of<ItemStore>(context, listen: false).renter.name;
                String to = widget.owner;
                String dateSent = DateTime.now().toString();
                String subject = widget.item.name;
                String body = messageController.text;
                String status = 'sent';
                Message message = Message(id: uuid.v4(), author: author, to: to, dateSent: dateSent, subject: subject, body: body, status: status, linkedId: '');
                Provider.of<ItemStore>(context, listen: false).addMessage(message);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.send, color: Colors.lightGreen, size: width * 0.07)
            )
              ],
            ),

          ],),
        )
      ),
      );
  }
}
