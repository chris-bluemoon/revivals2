import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numpad_layout/widgets/numpad.dart';
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
    brands.sort((a, b) => a.compareTo(b));
    colours.sort((a, b) => a.compareTo(b));
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

  List<String> brands = [
    'BARDOT',
    'HOUSE OF CB',
    'LEXI',
    'AJE',
    'ALC',
    'BRONX AND BANCO',
    'ELIYA',
    'NADINE MERABI',
    'REFORMATION',
    'SELKIE',
    'ZIMMERMANN',
    'ROCOCO SAND',
    'BAOBAB'
  ];


  List<String> imagePath = [];
  String shortDesc = 'This is my short description';

  bool readyToSubmit = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final List<XFile> _images = [];

  FirebaseStorage storage = FirebaseStorage.instance;

  String number = '';
  String retailPrice = '';

  final titleController = TextEditingController();
  final shortDescController = TextEditingController();
  final longDescController = TextEditingController();

  bool formComplete = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    log('Main rebuild');
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
      body: SingleChildScrollView(
        child: Padding(
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(width * 0.03),
                                      child: ListTile(
                                        trailing: Icon(Icons.close,
                                            color: Colors.white,
                                            size: width * 0.04),
                                        leading: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.black,
                                                size: width * 0.04)),
                                        title: const Center(
                                            child: StyledBody('PRODUCT TYPE')),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05),
                                          child: ListView.separated(
                                              itemCount: productTypes.length,
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Divider(height: height * 0.05),
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      formComplete = true;
                                                      productTypeValue =
                                                          productTypes[index];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                      // height: 50,
                                                      child: StyledBody(
                                                          productTypes[index])),
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
                      icon:
                          Icon(Icons.chevron_right_outlined, size: width * 0.05))
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const StyledBody('Colours'),
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(width * 0.03),
                                      child: ListTile(
                                        trailing: Icon(Icons.close,
                                            color: Colors.white,
                                            size: width * 0.04),
                                        leading: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.black,
                                                size: width * 0.04)),
                                        title: const Center(
                                            child: StyledBody('COLOURS')),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05),
                                          child: ListView.separated(
                                              itemCount: colours.length,
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Divider(height: height * 0.05),
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      colourValue =
                                                          colours[index];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                      // height: 50,
                                                      child: StyledBody(
                                                          colours[index])),
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
                      icon:
                          Icon(Icons.chevron_right_outlined, size: width * 0.05))
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
                                        trailing: Icon(Icons.close,
                                            color: Colors.white,
                                            size: width * 0.04),
                                        leading: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.black,
                                                size: width * 0.04)),
                                        title: const Center(
                                            child: StyledBody('BRAND')),
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
                                          padding: EdgeInsets.fromLTRB(
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05,
                                              width * 0.05),
                                          child: ListView.separated(
                                              itemCount: brands.length,
                                              separatorBuilder: (BuildContext
                                                          context,
                                                      int index) =>
                                                  Divider(height: height * 0.05),
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      brandValue = brands[index];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                      // height: 50,
                                                      child: StyledBody(
                                                          brands[index])),
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
                      icon:
                          Icon(Icons.chevron_right_outlined, size: width * 0.05))
                ],
              ),
                          const Divider(),
              Row(
                children: [
                  const StyledBody('Retail Price'),
                  const Expanded(child: SizedBox()),
                  Consumer<ItemStore>(builder: (BuildContext context, value, Widget? child) { 
                    return StyledBody(value.retailPrice);
                    // return StyledBody(Provider.of<ItemStore>(context, listen: false).retailPrice);
                   },
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {  
                              log('Building bottomshee;');
                                return FractionallySizedBox(
                                  heightFactor: 0.9,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(width * 0.03),
                                        child: ListTile(
                                          trailing: Icon(Icons.close,
                                              color: Colors.white,
                                              size: width * 0.04),
                                          leading: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close,
                                                  color: Colors.black,
                                                  size: width * 0.04)),
                                          title: const Center(
                                              child: StyledBody('RETAIL PRICE')),
                                        ),
                                      ),
                  Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: const StyledBody('The retail price of market value (if no longer in production) of the item', weight: FontWeight.normal),
                  ),
                                
                                                NumPad(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  onType: (value) {
                                                    setState(() {
                                                      if (number.isEmpty) {
                                                        number += '\$$value';
                                                      } else {
                                                        (number += value); 
                                                      }
                                                    });
                                                  },
                                                  rightWidget: IconButton(
                                                    icon: const Icon(Icons.backspace),
                                                    onPressed: () {
                                                      if (number.isNotEmpty) {
                                                        setState(() {
                                                          number = number.substring(0, number.length - 1);
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: width * 0.1),
                                                StyledBody(number),
                                                const Divider(),
                                                SizedBox(height: width * 0.1),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    retailPrice = number;
                                                    Provider.of<ItemStore>(context, listen: false).setRetailPrice(number);
                                                    Navigator.pop(context);
                                                  }, 
                                                  child: const StyledBody('Save')),
                                    ],
                                  ),
                                );}
                              );
                            });
                      },
                      icon:
                          Icon(Icons.chevron_right_outlined, size: width * 0.05))
                ],
              ),
                          const Divider(),
              SizedBox(height: width * 0.04),
              const Row(
                children: [
                  StyledBody('Describe your item'),
                ],
              ),
              SizedBox(height: width * 0.01),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 60,
                      controller: titleController,
                      onChanged: (text) {
                        // checkContents(text);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black)
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Title",
                        fillColor: Colors.white70,
                      ),
                    ),
                    // SizedBox(height: width * 0.01),
              TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 2,
                      maxLines: null,
                      maxLength: 200,
                      controller: shortDescController,
                      onChanged: (text) {
                        // checkContents(text);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black)
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Short Description",
                        fillColor: Colors.white70,
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: null,
                      maxLength: 1000,
                      controller: longDescController,
                      onChanged: (text) {
                        // checkContents(text);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.black)
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Long Description",
                        fillColor: Colors.white70,
                      ),
                    ),
            ],
          ),
        ),
      ),
                  bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (!formComplete) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('CONTINUE', weight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (formComplete) Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      handleSubmit();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('CONTINUE', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }

  handleSubmit() {
      // String type, String colour, String size, List<String> imagePath) {
    log('handleSubmit - Adding item (addItem) to ItemStore');
    String ownerId = Provider.of<ItemStore>(context, listen: false).renter.id;
    Provider.of<ItemStore>(context, listen: false).addItem(Item(
        id: uuid.v4(),
        owner: ownerId,
        type: productTypeValue,
        bookingType: allItems[0].bookingType,
        occasion: allItems[0].occasion,
        dateAdded: allItems[0].dateAdded,
        style: allItems[0].style,
        name: titleController.text,
        brand: allItems[0].brand,
        colour: [colourValue],
        size: ['6'],
        length: allItems[0].length,
        print: allItems[0].print,
        sleeve: allItems[0].sleeve,
        rentPrice: int.parse(retailPrice.substring(1)),
        buyPrice: allItems[0].buyPrice,
        rrp: allItems[0].rrp,
        description: shortDescController.text,
        bust: allItems[0].bust,
        waist: allItems[0].waist,
        hips: allItems[0].hips,
        longDescription: longDescController.text,
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
