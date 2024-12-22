import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/screens/profile/create/set_pricing.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart'; 

var uuid = const Uuid();

class CreateItem extends StatefulWidget {
  const CreateItem({required this.item, super.key});

  final Item? item;

  // final item;

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  @override
  void initState() {
    brands.sort((a, b) => a.compareTo(b));
    colours.sort((a, b) => a.compareTo(b));
    if (widget.item != null) {
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
     
      for (String itemImageString in widget.item!.imageId) {
        if (i.id == itemImageString) {
          _images.add(i.imageId);
        }

      }
      // if (i.id == widget.item?.imageId[0]) {
      //   // setState(() {
      //     // thisImage = Image.asset('assets/img/items2/AJE_Breathless_Frill_Sleeves_Dress_1.jpg');
      //     thisImage = i.imageId;
      //     _images.add(thisImage);
      //   // }
      //   // );
      // }
    }
    }
    super.initState();
  }

  late Image thisImage;

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
  String retailPriceValue = '';

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
  // final List<XFile> _images = [];
  final List<Image> _images = [];

  FirebaseStorage storage = FirebaseStorage.instance;

  String number = '';

  final titleController = TextEditingController();
  final retailPriceController = TextEditingController();
  final shortDescController = TextEditingController();
  final longDescController = TextEditingController();

  bool formComplete = false;

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
                        ? SizedBox(width: 80, child: _images[0])
                        : Icon(Icons.image_outlined, size: width * 0.2),
                    SizedBox(width: width * 0.02),
                    (_images.length > 1)
                        ? SizedBox(width: 80, child: _images[1])
                        : Icon(Icons.image_outlined, size: width * 0.2),
                    SizedBox(width: width * 0.02),
                    (_images.length > 2)
                        ? SizedBox(width: 80, child: _images[2])
                        : Icon(Icons.image_outlined, size: width * 0.2),
                    SizedBox(width: width * 0.02),
                    (_images.length > 3)
                        ? SizedBox(width: 80, child: _images[3])
                        : Icon(Icons.image_outlined, size: width * 0.2),
                  ],
                ),
                onTap: () {
                  getImage();
                },
              ),
        
              // Product Type bottom modal
              SizedBox(height: width * 0.02),
              // if (widget.item != null) thisImage,
              const Divider(),
              Row(
                children: [
                  const StyledBody('Product Type'),
                  const Expanded(child: SizedBox()),
                  StyledBody(productTypeValue),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                            backgroundColor: Colors.white,
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
                            backgroundColor: Colors.white,
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
                  StyledBody(retailPriceValue),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {  
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
                  Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: TextField(
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          maxLength: 10,
                          controller: retailPriceController,
                          onChanged: (text) {
                            setState(() {
                              // Provider.of<ItemStore>(context, listen: false).setRetailPrice(text);
                              retailPriceValue = text;
                            });
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
                            hintText: "Daily Price",
                            fillColor: Colors.white70,
                          ),
                        ),
                  ),
                                                // NumPad(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                //   onType: (value) {
                                                //     setState(() {
                                                //       if (number.isEmpty) {
                                                //         number += '\$$value';
                                                //       } else {
                                                //         (number += value); 
                                                //       }
                                                //     });
                                                //   },
                                                //   rightWidget: IconButton(
                                                //     icon: const Icon(Icons.backspace),
                                                //     onPressed: () {
                                                //       if (number.isNotEmpty) {
                                                //         setState(() {
                                                //           number = number.substring(0, number.length - 1);
                                                //         });
                                                //       }
                                                //     },
                                                //   ),
                                                // ),
                                                // SizedBox(height: width * 0.1),
                                                // StyledBody(number),
                                                // const Divider(),
                                                // SizedBox(height: width * 0.1),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // retailPrice = number;
                                                    // Provider.of<ItemStore>(context, listen: false).setRetailPrice(number);
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
                      // handleSubmit();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => (SetPricing(productTypeValue, brandValue, titleController.text, colourValue, retailPriceValue, shortDescController.text, longDescController.text, imagePath))));
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

  Future getImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1500,
        imageQuality: 100);
    if (image != null) {
      // Image tempImage = Image.file(File(_images[1].path), width: 80)
      // _images.add(Image.file(File(image.path), width: 80));
      _images.add(Image.file(File(image.path)));
    }

    setState(() {
      _image = image;
      // await FirebaseStorage.instance.ref(imageRef).putFile(videoFile);
      // uploadPic();
      if (_image == null) {
       
      }
    });
    uploadFile();
    // handleSubmit();
  }

  Future<String> uploadFile() async {
    String id = Provider.of<ItemStore>(context, listen: false).renter.id;
    String rng = uuid.v4();
    Reference ref = storage.ref().child('items').child(id).child('$rng.png');
   
    File file = File(_image!.path);
    UploadTask uploadTask = ref.putFile(file);
   
    TaskSnapshot taskSnapshot = await uploadTask;
    //
    imagePath.add(ref.fullPath.toString());
   
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
     
    }
  }
}
