import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/shared/styled_text.dart';


class MyItemImageWidget extends StatefulWidget {
  MyItemImageWidget(this.item, {super.key});

  final Item item;
  Image? _image;


  @override
  State<MyItemImageWidget> createState() => _MyItemImageWidgetState();
}

class _MyItemImageWidgetState extends State<MyItemImageWidget> {
  String imageName = '';

  @override
  void initState() {
    super.initState();
    getImageFromFirebase();
  }
  
  getImageFromFirebase() async {
    List<String> elementIds = widget.item.imageId[0].split('/');
 
    final ref = FirebaseStorage.instance.ref().child(elementIds[0]).child(elementIds[1]);
    var url = await ref.getDownloadURL();
    setState(() {
      widget._image = Image.network(url, width: 50,);
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   
    return Card(
      margin: EdgeInsets.only(bottom: width*0.04),
      shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: width * 0.1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.03),
                    const StyledBody('MY ITEM', weight: FontWeight.normal,),
                    SizedBox(height: width * 0.03),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: const StyledBody('Item ID', color: Colors.grey, weight: FontWeight.normal)),
                        SizedBox(width: width * 0.01),
                        (widget._image != null) ? widget._image! : const Text('NO IMAGE'),
                      ],
                    ),
                    SizedBox(height: width * 0.03),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

}
