import 'package:cloud_firestore/cloud_firestore.dart';

class Ledger {
  
  Ledger({required this.id, 
          required this.owner, 
          required this.date, 
          required this.desc, 
          required this.amount, 
          required this.balance,
        });

    String id;
    String owner;
    String date;
    String desc;
    int amount;
    int balance;

  Map<String, dynamic> toFirestore() {
    return {
      'owner': owner,
      'date': date,
      'desc': desc,
      'amount': amount,
      'balance': balance,
    };
  }

  // character from firestore
  factory Ledger.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    final data = snapshot.data()!;

    Ledger ledger = Ledger(
      id: snapshot.id,
      owner: data['owner'],
      date: data['date'],
      desc: data['desc'],
      amount: data['amount'],
      balance: data['balance'],
    );

    return ledger;
  } 
  
  
}