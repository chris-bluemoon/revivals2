import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/message.dart';
import 'package:revivals/services/class_store.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class SendMessage2 extends StatefulWidget {
  const SendMessage2(this.from, this.to, this.subject, {super.key});

  final String from;
  final String to;
  final String subject;

  @override
  State<SendMessage2> createState() => _SendMessage2State();
}

class _SendMessage2State extends State<SendMessage2> {

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
    return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, width * 0.05, 0),
          child: 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.close, size: width * 0.06)
                ),
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
              visualDensity: VisualDensity.compact,
              onPressed: () {
                String author = Provider.of<ItemStore>(context, listen: false).renter.name;
                String to = widget.to;
                String dateSent = DateTime.now().toString();
                String subject = widget.subject;
                String body = messageController.text;
                String status = 'sent';
                Message message = Message(id: uuid.v4(), author: author, to: to, dateSent: dateSent, subject: subject, body: body, status: status, linkedId: '');
                Provider.of<ItemStore>(context, listen: false).addMessage(message);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.send, color: Colors.lightGreen, size: width * 0.06)
            )
              ],
    ),
        );
  }
}