import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/services/class_store.dart';



class DownloadPics extends StatefulWidget {
  const DownloadPics({super.key});

  @override
  State<DownloadPics> createState() => _DownloadPicsState();
}

class _DownloadPicsState extends State<DownloadPics> {
  
  @override
  void initState() {
    super.initState();
  }

  Image? _image;

  var url = '';

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
                : Image.network(url)
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: Provider.of<ItemStore>(context, listen: false).fetchImages,
            // onPressed: getImage,
            tooltip: 'Pick Image',
            child: const Icon(Icons.add_a_photo),
          ),
        );
  }

  Future getImage() async {
      downloadFile();
  }

  downloadFile() async {
    String id = Provider.of<ItemStore>(context, listen:false).renter.id;
    String dressName = Provider.of<ItemStore>(context, listen:false).renter.id;
    final ref = FirebaseStorage.instance.ref().child('folder1').child('folder2').child('testimage');
    // final ref = FirebaseStorage.instance.ref().child('$id').child('dressName').child('images.png');
    url = await ref.getDownloadURL();
    print(url);
    setState(() {
      _image = Image.network(url);
    }); 
  }
}
