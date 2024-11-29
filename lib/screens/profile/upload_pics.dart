import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revivals/services/class_store.dart';



class UploadPics extends StatefulWidget {
  const UploadPics({super.key});

  @override
  State<UploadPics> createState() => _UploadPicsState();
}

class _UploadPicsState extends State<UploadPics> {
  
  @override
  void initState() {
    super.initState();
  }

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
          body: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: const Icon(Icons.add_a_photo),
          ),
        );
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
    Reference ref = storage.ref().child(id).child("testimage");
    print('REFERENCE: $ref');
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
    print('UPLOAD TASK${uploadTask.snapshot}');
    TaskSnapshot taskSnapshot = await uploadTask;
    log(ref.bucket.toString());
    log(ref.fullPath.toString());
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
      log(item.toString());
    }
  }

}
