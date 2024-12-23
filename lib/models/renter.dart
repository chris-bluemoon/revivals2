import 'package:cloud_firestore/cloud_firestore.dart';

class Renter {
  
  Renter({required this.id, 
          required this.email, 
          required this.name, 
          required this.size, 
          required this.address, 
          required this.countryCode,
          required this.phoneNum,
          required this.favourites,
          required this.fittings,
          required this.settings,
          required this.verified,
          required this.imagePath,
          required this.creationDate,
        }); 

    String id;
    String email;
    String name;
    int size;
    String address;
    String countryCode;
    String phoneNum;
    List favourites;
    List fittings;
    List settings;
    String verified;
    String imagePath;
    String creationDate;

  // item to firestore (map)
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'size': size,
      'address': address,
      'countryCode': countryCode,
      'phoneNum': phoneNum,
      'favourites': favourites,
      'fittings': fittings,
      'settings': settings,
      'verified': verified,
      'imagePath': imagePath,
      'creationDate': creationDate,
    };
  }

  // character from firestore
  factory Renter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {

    // get data from snapshot
    final data = snapshot.data()!;
    // make character instance
    Renter renter = Renter(
      id: snapshot.id,
      email: data['email'],
      name: data['name'],
      size: data['size'],
      address: data['address'],
      countryCode: data['countryCode'],
      phoneNum: data['phoneNum'],
      favourites: data['favourites'],
      fittings: data['fittings'],
      settings: data['settings'],
      verified: data['verified'],
      imagePath: data['imagePath'],
      creationDate: data['creationDate'],
    );

    return renter;
  } 
  
  
}
