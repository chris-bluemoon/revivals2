import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_image.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';

class SummaryImageWidget extends StatefulWidget {
  const SummaryImageWidget(this.item, {super.key});

  final Item item;

  @override
  State<SummaryImageWidget> createState() => _SummaryImageWidgetState();
}

class _SummaryImageWidgetState extends State<SummaryImageWidget> {
  late String itemType;

  late String itemName;

  late String brandName;

  late String imageName;

  // String setItemImage() {
  //   itemType = toBeginningOfSentenceCase(widget.item.type.replaceAll(RegExp(' +'), '_'));
  //   itemName = widget.item.name.replaceAll(RegExp(' +'), '_');
  //   brandName = widget.item.brand.replaceAll(RegExp(' +'), '_');
  //   imageName = '${brandName}_${itemName}_${itemType}_1.jpg';
  //   return imageName;
  // }

  Image thisImage = Image.asset('assets/img/items2/No_Image_Available.jpg',
                      fit: BoxFit.fitHeight,
                    height: 200,
                    width: 100);

  // String getSize(int size) {
    String getSize(sizeArray) {
    String formattedSize = 'N/A';
    if (sizeArray.length == 1) {
      formattedSize = sizeArray.first;
    }
    if (sizeArray.length == 2) {
      String firstSize;
      String secondSize;
      firstSize = sizeArray.elementAt(0);
      secondSize = sizeArray.elementAt(1);
       formattedSize = '$firstSize-$secondSize';
    }
    return formattedSize;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; 
    for (ItemImage i in Provider.of<ItemStore>(context, listen: false).images) {
      if (i.id == widget.item.imageId[0]) {
        setState(() {
          thisImage = i.imageId;
        }
        );
      }
    }
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: width * 0.25,
              width: width * 0.2,
              child: thisImage),
          ),
              // Image.asset('assets/img/items2/${setItemImage()}', fit: BoxFit.fitHeight, height: 0.25*width, width: 0.2*width)),
              // Image.asset('assets/img/items2/${setItemImage()}', fit: BoxFit.fitHeight, height: width*0.125, width: width*0.1)),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledHeading('${widget.item.name} from ${widget.item.brand}'),
              const SizedBox(height: 5),
              // TODO Sort this out
              StyledBody('Size UK ${getSize(widget.item.size)}', color: Colors.grey),
          ],)
        ],
      )

    );
  }
}