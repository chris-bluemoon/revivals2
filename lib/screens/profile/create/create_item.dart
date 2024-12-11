import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
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

  List<String> productTypes = ['Dress', 'Bag', 'Jacket', 'Suit Pant'];
  List<String> colours = [
    'Black',
    'White',
    'Blue',
    'Red',
    'Green',
    'Grey',
    'Brown',
    'Yellow',
    'Purple',
    'Pink',
    'Lime',
    'Cyan',
    'Teal'
  ];

  String productTypeValue = '';
  String colourValue = '';
  String brandValue = '';

  List<String> brands = ['BARDOT', 'HOUSE OF CB', 'LEXI', 'AJE', 'ALC', 'BRONX AND BANCO', 'ELIYA',
    'NADINE MERABI', 'REFORMATION', 'SELKIE', 'ZIMMERMANN', 'ROCOCO SAND', 'BAOBAB'];

  final shortDescController = TextEditingController();

  List<String> imagePath = [];
  String shortDesc = 'This is my short description';

  bool readyToSubmit = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final List<XFile> _images = [];

  FirebaseStorage storage = FirebaseStorage.instance;

  // Modal values

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('LIST ITEM'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_images.isNotEmpty)
                      ? Image.file(File(_images[0].path), width: 80)
                      : Icon(Icons.image_outlined, size: width * 0.2),
                  SizedBox(width: width * 0.02),
                  (_images.length > 1)
                      ? Image.file(File(_images[1].path), width: 80)
                      : Icon(Icons.image_outlined, size: width * 0.2),
                  SizedBox(width: width * 0.02),
                  (_images.length > 2)
                      ? Image.file(File(_images[2].path), width: 80)
                      : Icon(Icons.image_outlined, size: width * 0.2),
                  SizedBox(width: width * 0.02),
                  (_images.length > 3)
                      ? Image.file(File(_images[3].path), width: 80)
                      : Icon(Icons.image_outlined, size: width * 0.2),
                ],
              ),
              onTap: () {
                getImage();
              },
            ),
        
            // Product Type bottom modal
            SizedBox(height: width * 0.02),
            const Divider(),
            Row(
              children: [
                const StyledBody('Product Type'),
                const Expanded(child: SizedBox()),
                StyledBody(productTypeValue),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Container(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: productTypes.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              productTypeValue = productTypes[index];
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Center(
                                                child: StyledBody(productTypes[index])
                                            )
                                          ),
                                        );
                                      })),
                            );
                          });
                    },
                    icon: Icon(Icons.chevron_right_outlined, size: width * 0.05))
              ],
            ),
                    const Divider(),
            Row(
              children: [
                const StyledBody('Colour'),
                const Expanded(child: SizedBox()),
                StyledBody(colourValue),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Container(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: colours.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              colourValue = colours[index];
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Center(
                                                child: StyledBody(colours[index])
                                            )
                                          ),
                                        );
                                      })),
                            );
                          });
                    },
                    icon: Icon(Icons.chevron_right_outlined, size: width * 0.05))
              ],
            ),
                        const Divider(),
            Row(
              children: [
                const StyledBody('Brand'),
                const Expanded(child: SizedBox()),
                StyledBody(brandValue),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.9,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.03),
                                    child: ListTile(
                                      trailing: Icon(Icons.close, color: Colors.white, size: width * 0.04),
                                      leading: Icon(Icons.close, color: Colors.black, size: width * 0.04),
                                      title: const Center(child: StyledBody('BRAND')),
                                      // leading: IconButton(
                                      //   onPressed: () {
                                      //     Navigator.pop(context);
                                      //   }, 
                                      //   icon: Icon(Icons.close, size: width * 0.04))
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(width * 0.05, width * 0.05, width * 0.05, width * 0.05),
                                        child: ListView.separated(
                                            itemCount: brands.length,
                                            separatorBuilder: (BuildContext context, int index) => Divider(height: height * 0.05),
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    brandValue = brands[index];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: SizedBox(
                                                  // height: 50,
                                                  child: StyledBody(brands[index])
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.chevron_right_outlined, size: width * 0.05))
              ],
            ),
          ],
        ),
      ),
    );
  }

  handleSubmit(
      String type, String colour, String size, List<String> imagePath) {
    log('handleSubmit - Adding item (addItem) to ItemStore');
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
        colour: [colour],
        size: [size],
        length: allItems[0].length,
        print: allItems[0].print,
        sleeve: allItems[0].sleeve,
        rentPrice: allItems[0].rentPrice,
        buyPrice: allItems[0].buyPrice,
        rrp: allItems[0].rrp,
        description: shortDescController.text,
        bust: allItems[0].bust,
        waist: allItems[0].waist,
        hips: allItems[0].hips,
        longDescription: allItems[0].longDescription,
        imageId: imagePath,
        status: 'submitted'
        // imageId: allItems[0].imageId,
        ));
  }

  Future getImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1500,
        imageQuality: 100);
    if (image != null) {
      _images.add(image);
    }

    setState(() {
      _image = image;
      // await FirebaseStorage.instance.ref(imageRef).putFile(videoFile);
      // uploadPic();
      if (_image == null) {
        log('IMAGE IS NULL');
      }
    });
    uploadFile();
    // handleSubmit();
  }

  Future<String> uploadFile() async {
    String id = Provider.of<ItemStore>(context, listen: false).renter.id;
    String rng = uuid.v4();
    Reference ref = storage.ref().child(id).child('$rng.png');
    log('REFERENCE: $ref');
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
    log('UPLOAD TASK${uploadTask.snapshot}');
    TaskSnapshot taskSnapshot = await uploadTask;
    // log(ref.bucket.toString());
    imagePath.add(ref.fullPath.toString());
    log('imagePath has been set, ready to handleSubmit');
    setState(() {
      readyToSubmit = true;
    });
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
}