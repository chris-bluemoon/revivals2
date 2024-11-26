import 'package:cloud_firestore/cloud_firestore.dart';

class ItemRenter {
  
  ItemRenter({required this.id, 
          required this.renterId, 
          required this.itemId,
          required this.transactionType, 
          required this.startDate, 
          required this.endDate, 
          required this.price,
          required this.status,
        }); 

    String id;
    String renterId;
    String itemId;
    String transactionType;
    String startDate;
    String endDate;
    int price;
    String status;

  // item to firestore (map)
  Map<String, dynamic> toFirestore() {
    return {
      'renterId': renterId,
      'itemId': itemId,
      'transactionType': transactionType,
      'startDate': startDate,
      'endDate': endDate,
      'price': price,
      'status': status,
    };
  }

  // ItemRenter from firestore
  factory ItemRenter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;

    // make character instance
    ItemRenter itemRenter = ItemRenter(
      id: snapshot.id,
      renterId: data['renterId'],
      itemId: data['itemId'],
      transactionType: data['transactionType'],
      startDate: data['startDate'],
      endDate: data['endDate'],
      price: data['price'],
      status: data['status'],
    );

    return itemRenter;
  } 
  
  
}

// List<Item> items = [
//   Item(id: 1, name: 'Mathilde Bubble', brand: 'AJE', size: 52, rentPrice: 1200, rrp: 12000, image: 'AJE_Mathilde_Bubble_Item.webp'),
//   Item(id: 2, name: 'Carla', brand: 'ELIYA', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
//   Item(id: 3, name: 'Elinor', brand: 'ELIYA', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
//   Item(id: 4, name: 'Francesca Mini', brand: 'ELIYA', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
//   Item(id: 5, name: 'Dione', brand: 'LEXI', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
//   Item(id: 6, name: 'Riley Chiffon', brand: 'LEXI', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
//   Item(id: 7, name: 'Sheena', brand: 'LEXI', size: 52, rentPrice: 1200, rrp: 12000, image: '3_item.jpg'),
// ];