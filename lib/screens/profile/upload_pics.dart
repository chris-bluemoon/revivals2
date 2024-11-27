import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



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
      uploadPic();
    });
  }

  Future<String> uploadPic() async {

    //Get the file from the image picker and store it 
    // XFile? image = await ImagePicker.pickImage(source: ImageSource.gallery);  

    //Create a reference to the location you want to upload to in firebase  
    // StorageReference reference = storage.ref().child("images/");
    Reference ref = storage.ref().child("image1${DateTime.now()}");
    log(ref.toString());
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
    String location= '';
    uploadTask.then((res) {
      location = res.ref.getDownloadURL() as String;
    });

    return location;
   }
}
