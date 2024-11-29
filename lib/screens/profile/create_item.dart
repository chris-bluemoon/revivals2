import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/screens/profile/dropdown_type.dart';
import 'package:revivals/services/class_store.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();



class CreateItem extends StatefulWidget {
  const CreateItem({super.key});

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  
  @override
  void initState() {
    super.initState();
  }
  
  String itemType = 'dummy';
  String imagePath = 'dummy';

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
          appBar: AppBar(
            title: const Text('Example of Image Picker in flutter'),
          ),
          body: Column(
            children: [
              DropdownType(setType),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: const Text('Add Image'),
              ),
              Center(
                child: _image == null
                    ? const Text('No image selected.')
                    : Image.file(File(_image!.path), width: 100,),
              ),
              ElevatedButton(
                onPressed: _image != null ? () {
                  if (_image != null) {
                    handleSubmit(itemType, imagePath);
                    Navigator.pop(context);
                  } 
                } : null,
                child: const Text('Upload')
                )
            ],
          ),

        );
  }

  handleSubmit(String type, String imagePath) {
    log('Uploading...');
    String ownerId = Provider.of<ItemStore>(context, listen: false).renter.id;
      Provider.of<ItemStore>(context, listen: false).addItem(Item(
        id: uuid.v4(),
        owner: ownerId,
        type: type,
        bookingType: allItems[0].bookingType,
        occasion: allItems[0].occasion,
        dateAdded: allItems[0].dateAdded,
        style: allItems[0].style,
        name: allItems[0].name,
        brand: allItems[0].brand,
        colour: allItems[0].colour,
        size: allItems[0].size,
        length: allItems[0].length,
        print: allItems[0].print,
        sleeve: allItems[0].sleeve,
        rentPrice: allItems[0].rentPrice,
        buyPrice: allItems[0].buyPrice,
        rrp: allItems[0].rrp,
        description: allItems[0].description,
        bust: allItems[0].bust,
        waist: allItems[0].waist,
        hips: allItems[0].hips,
        longDescription: allItems[0].longDescription,
        imageId: [imagePath],
        // imageId: allItems[0].imageId,
    ));
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      _image = image;
      // await FirebaseStorage.instance.ref(imageRef).putFile(videoFile);
      // uploadPic();
      uploadFile();
      listFiles();
    });
  }

  Future<String> uploadFile() async {
    String id = Provider.of<ItemStore>(context, listen:false).renter.id;
    String rng = uuid.v4();
    Reference ref = storage.ref().child(id).child('$rng.png');
    print('REFERENCE: $ref');
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
    print('UPLOAD TASK${uploadTask.snapshot}');
    TaskSnapshot taskSnapshot = await uploadTask;
    // log(ref.bucket.toString());
    // imagePath = ref.fullPath.toString();
    // log('Formed string ready for upload: $imagePath');
    return await taskSnapshot.ref.getDownloadURL();
  }

  listFiles() async {
    final storageRef = FirebaseStorage.instance.ref();
    final listResult = await storageRef.listAll();

  // for (var prefix in listResult.prefixes) {
  // The prefixes under storageRef.
  // You can call listAll() recursively on them.
  // }
    for (var ref in listResult.items) {
        print('Found file: $ref');
    }

    for (var item in listResult.items) {
      log('HERE ${item.toString()}');
    }
  }

  setType(String type) {
    itemType = type;
  }

}
