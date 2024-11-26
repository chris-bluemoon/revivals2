import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revivals/models/fitting_renter.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/models/renter.dart';

class FirestoreService {

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
     }
    );
  }

  // get renters once
  static Future<QuerySnapshot<Renter>> getRentersOnce() {
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
  
  static deleteItems() {
  FirebaseFirestore.instance
    .collection('item').get().then((snapshot) {
      log('Deleting items firestore service');
      for (DocumentSnapshot i in snapshot.docs) {
        log('DELETED ITEMS');
        i.reference.delete();
      }
    });
  }
  static deleteItemRenters() {
  FirebaseFirestore.instance
    .collection('itemRenter').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        log('DELETED ITEMRENTER');
        ds.reference.delete();
      }
    });
  }
  static deleteFittingRenters() {
  FirebaseFirestore.instance
    .collection('fittingRenter').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        log('DELETED FITTINGRENTER');
        ds.reference.delete();
      }
    });
  }
  
}