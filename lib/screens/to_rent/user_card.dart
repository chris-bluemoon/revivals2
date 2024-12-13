import 'package:flutter/material.dart';
import 'package:revivals/shared/styled_text.dart';

class UserCard extends StatelessWidget {
  const UserCard(this.ownerName, this.location, this.sendMail, {super.key});

  final String ownerName;
  final String location;
  final bool sendMail;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String initialLetter = ownerName.substring(0, 1);
    return Container(
        child: Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.greenAccent[400],
            radius: width * 0.04,
            child: Text(
              initialLetter,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            )), //Text
        SizedBox(width: width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          StyledBody(ownerName),
          StyledBody(location, weight: FontWeight.normal)
        ],),
        SizedBox(width: width * 0.03),
        if (!sendMail) const Icon(Icons.email_outlined, size: 40)
      ],
    )
        // if (sendMessagePressed) Expanded(child: SendMessage(setSendMessagePressedToFalse, from: Provider.of<ItemStore>(context, listen: false).renter.name, to: ownerName, subject: widget.item.name)),

        );
  }
}
