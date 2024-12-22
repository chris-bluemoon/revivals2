import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/models/message.dart';
import 'package:revivals/models/renter.dart';

class FirestoreService {

  static final refMessage = FirebaseFirestore.instance
    .collection('message')
    .withConverter(
      fromFirestore: Message.fromFirestore, 
      toFirestore: (Message d, _) => d.toFirestore()
  );

  static final refItem = FirebaseFirestore.instance
    .collection('item')
    .withConverter(
      fromFirestore: Item.fromFirestore, 
      toFirestore: (Item d, _) => d.toFirestore()
  );

  static final refRenter = FirebaseFirestore.instance
    .collection('renter')
    .withConverter(
      fromFirestore: Renter.fromFirestore, 
      toFirestore: (Renter d, _) => d.toFirestore()
  );

  static final refItemRenter = FirebaseFirestore.instance
    .collection('itemRenter')
    .withConverter(
      fromFirestore: ItemRenter.fromFirestore, 
      toFirestore: (ItemRenter d, _) => d.toFirestore()
  );

  static final refFittingRenter = FirebaseFirestore.instance
    .collection('fittingRenter')
    .withConverter(
      fromFirestore: FittingRenter.fromFirestore, 
      toFirestore: (FittingRenter d, _) => d.toFirestore()
  );

  // add a new message
  static Future<void> addMessage(Message message) async {
    await refMessage.doc(message.id).set(message);
  }

  // add a new item
  static Future<void> addItem(Item item) async {
    await refItem.doc(item.id).set(item);
  }

  // get item once
  static Future<QuerySnapshot<Item>> getItemsOnce() {
    return refItem.get();
  }

  // add a new renter
  static Future<void> addRenter(Renter renter) async {
    await refRenter.doc(renter.id).set(renter);
  }

  // Update renter
  static Future<void> updateRenter(Renter renter) async {
    await refRenter.doc(renter.id).update(
      {
        'address': renter.address,
        'phoneNum': renter.phoneNum,
        'favourites': renter.favourites,
        'fittings': renter.fittings,
        'settings': renter.settings,
        'verified': renter.verified,
        'imagePath': renter.imagePath,
     }
    );
  }

  // get renters once
  static Future<QuerySnapshot<Renter>> getRentersOnce() {
    log('HERE');
    return refRenter.get();
  }

  // add a new renterItem
  static Future<void> addItemRenter(ItemRenter itemRenter) async {
    await refItemRenter.doc(itemRenter.id).set(itemRenter);
  }

  static Future<void> addFittingRenter(FittingRenter fittingRenter) async {
    await refFittingRenter.doc(fittingRenter.id).set(fittingRenter);
  }

  // get itemRenters once
  static Future<QuerySnapshot<Message>> getMessagesOnce() {
    return refMessage.get();
  }

  static Future<QuerySnapshot<ItemRenter>> getItemRentersOnce() {
    return refItemRenter.get();
  }
  static Future<QuerySnapshot<FittingRenter>> getFittingRentersOnce() {
    return refFittingRenter.get();
  }
  // Update itemrenter
  // Update itemrenter
  static Future<void> updateItemRenter(ItemRenter itemRenter) async {
    await refItemRenter.doc(itemRenter.id).update(
      {
        'status': itemRenter.status,
     }
    );
  }
  static Future<void> updateFittingRenter(FittingRenter fittingRenter) async {
    await refFittingRenter.doc(fittingRenter.id).update(
      {
        'status': fittingRenter.status,
     }
    );
  }

  static Future<void> updateMessage(Message message) async {
    await refMessage.doc(message.id).update(
      {
        'status': message.status,
     }
    );
  }

  static Future<void> updateItem(Item item) async {
    await refItem.doc(item.id).update(
      {
        'status': item.status,
     }
    );
  }
  
  static deleteItems() {
  FirebaseFirestore.instance
    .collection('item').get().then((snapshot) {
     
      for (DocumentSnapshot i in snapshot.docs) {
       
        i.reference.delete();
      }
    });
  }
  static deleteItemRenters() {
  FirebaseFirestore.instance
    .collection('itemRenter').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
       
        ds.reference.delete();
      }
    });
  }
  static deleteFittingRenters() {
  FirebaseFirestore.instance
    .collection('fittingRenter').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
       
        ds.reference.delete();
      }
    });
  }
  
}