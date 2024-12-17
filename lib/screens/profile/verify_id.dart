import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class VerifyId extends StatefulWidget {
  const VerifyId({super.key});

  @override
  State<VerifyId> createState() => _VerifyIdState();
}

class _VerifyIdState extends State<VerifyId> {
  

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  Image? _image;
  String imagePath = '';
  bool readyToSubmit = false;

  FirebaseStorage storage = FirebaseStorage.instance;
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('ID VERIFICATION'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
      body: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
        child: Column(
          children: [
            const StyledBody('In order get a verified account, please upload your ID by tapping the image below. Once we have verified your idenity, your account will be "green ticked" and shown on your account. "Green tick" accounts consistently attract more views and rentals', weight: FontWeight.normal),
            SizedBox(height: width * 0.03),
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: (_image == null) ? Icon(Icons.image_outlined, size: width * 0.2)
                : SizedBox(width: 100, child: _image)
            ),
            SizedBox(height: width * 0.03),
            ElevatedButton(
              onPressed: (!readyToSubmit) ? null : () {
               
                Navigator.pop(context);
              }, 
              child: (!readyToSubmit) ? const StyledBody('CANNOT UPLOAD') :
                const StyledBody('UPLOAD')
            )
        ],)

      )
    );
  }
    Future getImage() async {
    pickedFile = await _picker.pickImage(
       source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1500,
        imageQuality: 100);
    if (pickedFile != null) {
      // _images.add(Image.file(File(_image.path)));
      setState(() {
        _image = Image.file(File(pickedFile!.path));
      });
      uploadFile();
    }

  }    
  Future<String> uploadFile() async {
    String id = Provider.of<ItemStore>(context, listen: false).renter.id;
    String rng = uuid.v4();
    Reference ref = storage.ref().child(id).child('$rng.png');
   
    File file = File(pickedFile!.path);
    UploadTask uploadTask = ref.putFile(file);
   
    TaskSnapshot taskSnapshot = await uploadTask;
    //
    imagePath = ref.fullPath.toString();
   
    setState(() {
      readyToSubmit = true;
    });
    return await taskSnapshot.ref.getDownloadURL();
  }
}
