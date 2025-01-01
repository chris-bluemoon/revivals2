import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:revivals/shared/styled_text.dart';

class ViewImage extends StatefulWidget {
  ViewImage(this.thisImages, this.page, {super.key});
  
  int page;
  List<Image> thisImages;
  int currPage = 0;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  

@override
void initState() {
  super.initState();
  widget.currPage = widget.page;
}

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: widget.page-1);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: StyledTitle('${widget.currPage.toString()} / ${widget.thisImages.length}'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
    child: PhotoViewGallery.builder(
      onPageChanged: (page) {
        setState(() {
          log('Setting page');
          widget.currPage = page + 1;
        }); 
      },
      pageController: pageController,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: widget.thisImages[index].image,
          initialScale: PhotoViewComputedScale.contained * 1,
          // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
        );
      },
      // itemCount: galleryItems.length,
      itemCount: widget.thisImages.length,
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / 1,
          ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    )
  ));
  }
}