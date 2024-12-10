import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  
  Message({required this.id, 
          required this.author, 
          required this.to, 
          required this.dateSent,
          required this.subject, 
          required this.body, 
          required this.status,
          required this.linkedId
        });

    String id;
    String author;
    String to;
    String dateSent;
    String subject;
    String body;
    String status;
    String linkedId;

  Map<String, dynamic> toFirestore() {
    return {
      'author': author,
      'to': to,
      'dateSent': dateSent,
      'subject': subject,
      'body': body,
      'status': status,
      'linkedId': linkedId
    };
  }

  // character from firestore
  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    Message message = Message(
      id: snapshot.id,
      author: data['author'],
      to: data['to'],
      dateSent: data['dateSent'],
      subject: data['subject'],
      body: data['body'],
      status: data['status'],
      linkedId: data['linkedId'],
    );

    return message;
  } 
  
  
}
