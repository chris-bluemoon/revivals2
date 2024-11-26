import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/screens/home/fitting_home_widget.dart';
import 'package:revivals/screens/home/home_page_bottom_card.dart';
import 'package:revivals/screens/home/new_arrivals_carousel.dart';
import 'package:revivals/screens/home/offer_home_widget.dart';
import 'package:revivals/screens/home/rentals_home_widget.dart';
import 'package:revivals/screens/home/to_buy_home_widget.dart';
import 'package:revivals/screens/sign_up/google_sign_in.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/item_results.dart';
import 'package:revivals/shared/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List items = [1, 2];
  int currentIndex = 0;

  CarouselSliderController buttonCarouselSliderController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: width*0.2,
          // centerTitle: true,
          title: SizedBox(
              // TODO: Image is not centered in appbar with back arrow
              // mainAxisAlignment: MainAxisAlignment.center,
              child: Image.asset(
                  'assets/logos/unearthed_logo_3.png',
                  // 'assets/logos/unearthed_collections.png',
                  fit: BoxFit.fill,
                  height: width * 0.15,
                  // width: width * 0.4,
                ),
              ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display first column object, the carousel
              SizedBox(height: height*0.01),
              CarouselSlider(
                carouselController: buttonCarouselSliderController,
                options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    height: height * 0.2,
                    autoPlay: true),
                items: items.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return const OfferWidget();
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: width * 0.02),
              // Display dot indicators for carousel

              Center(
                child: DotsIndicator(
                  dotsCount: items.length,
                  position: currentIndex,
                  decorator: const DotsDecorator(
                    colors: [Colors.grey, Colors.grey],
                    activeColor: Colors.black,
                    // colors: [Colors.grey[300], Colors.grey[600], Colors.grey[900]], // Inactive dot colors
                  ),
                ),
              ),

              // // Now display the first home page widget, for now a simple icon button
              // SizedBox(height: width * 0.02),
              // const Padding(
              //   padding: EdgeInsets.only(left: 12.0),
              //   child: StyledHeading(
              //     'ALL ITEMS',
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('occasion', 'party'))));
              //   },
              //   child: const AllItemsHomeWidget()),

 

              SizedBox(height: width * 0.02),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StyledHeading(
                  'TO RENT',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('bookingType','rental'))));
                },
                child: const RentalHomeWidget()),
             SizedBox(height: width * 0.02),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StyledHeading(
                  'NEW ARRIVALS',
                ),
              ),
              // const NewArrivalsHomeWidget(),
              SizedBox(height: width * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('dateAdded', '01-01-2020'))));
                },
                child: const NewArrivalsCarousel()),

              SizedBox(height: width * 0.05),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StyledHeading(
                  'TO BUY',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('bookingType','buy'))));
                },
                child: const ToBuyHomeWidget()),

              SizedBox(height: width * 0.02),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StyledHeading(
                  'BOOK A FITTING ',
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const Fitting2())));
                  bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
                  (loggedIn) ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const ItemResults('fitting','dummy')))) 
                    : showAlertDialog(context);
                },
                child: const FittingHomeWidget()),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: StyledHeading('HELP CENTRE'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: height * 0.10,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    const SizedBox(width: 4),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const HygienePolicy())));
                    //   },
                    //   child: const HomePageBottomCard('Our Hygiene Policy')),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const FAQs())));
                        Navigator.pushNamed(context, '/faqs');
                      },
                      child: const HomePageBottomCard('General FAQs')),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const WhatIs())));
                        Navigator.pushNamed(context, '/whatIs');
                      },
                      child: const HomePageBottomCard('Who Are We?')),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const HowItWorks())));
                        Navigator.pushNamed(context, '/howItWorks');
                      },
                      child: const HomePageBottomCard('How It Works')),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const SizingGuide())));
                        Navigator.pushNamed(context, '/sizingGuide');
                      },
                      child: const HomePageBottomCard('Sizing Guide')),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
  showAlertDialog(BuildContext context) {  
  // Create button  
  double width = MediaQuery.of(context).size.width;


  Widget okButton = ElevatedButton(  
    style: OutlinedButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.white),
                          foregroundColor: Colors.white,//change background color of button
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        side: const BorderSide(width: 1.0, color: Colors.black),
      ),
    onPressed: () {  
      // Navigator.of(context).pop();  
      // Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen()))); 

    },  
    child: const Center(child: StyledHeading("OK", color: Colors.white)),  
  ); 
    // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    title: const Center(child: StyledHeading("NOT LOGGED IN")),
    content: SizedBox(
      height: width * 0.2,
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledHeading("Please log in"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledHeading("or register to continue"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledHeading("to book a fitting"),
            ],
          )
        ],
      ),
    ),  
    actions: [  
      okButton,  
    ],  
                shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
  );  
    showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );   
}
}
