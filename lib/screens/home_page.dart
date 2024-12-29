import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:revivals/screens/browse/browse.dart';
import 'package:revivals/screens/favourites/favourites.dart';
import 'package:revivals/screens/home/home.dart';
import 'package:revivals/screens/profile/profile.dart';
import 'package:revivals/services/class_store.dart';

double? screenWidth;
double? screenHeight;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initialization() async {
    log('pausing..');
    await Future.delayed(const Duration(seconds: 3));
    log('unpausing...');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    initialization();
    
    Provider.of<ItemStore>(context, listen: false)
      .fetchItemsOnce();
    Provider.of<ItemStore>(context, listen: false)
      .fetchItemRentersOnce();
    Provider.of<ItemStore>(context, listen: false)
      .fetchFittingRentersOnce();
    // Provider.of<ItemStore>(context, listen: false)
      // .fetchRentersOnce();
    Provider.of<ItemStore>(context, listen: false)
      .fetchMessagesOnce();
    // Provider.of<ItemStore>(context, listen: false)
      // .fetchImagesOnce();
    // Provider.of<ItemStore>(context, listen: false).populateFavourites();
    // Provider.of<ItemStore>(context, listen: false).populateFittings();

      
    // Provider.of<ItemStore>(context, listen: false).addAllFavourites();
    
    // getCurrentUser();
  }

  int _pageIndex = 0;

  bool loggedIn = false;

  final _pages = [
    const Home(),
    const Browse(),
    const Favourites(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[_pageIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontSize: width*0.025, color: Colors.black),
        selectedLabelStyle: TextStyle(fontSize: width*0.025, color: Colors.grey),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.home_outlined, size: width*0.05),
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.menu_book_outlined, size: width*0.05),
            ),
            label: 'BROWSE',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.favorite_border, size: width*0.05),
            ),
            label: 'FAVOURITES',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Icon(Icons.account_circle_outlined, size: width*0.05),
            ),
            label: 'PROFILE'
          ),
        ],
        // selectedLabelStyle: TextStyle(color: Colors.blue,fontSize: 14),
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(
            () {
              // getCurrentUser();
              _pageIndex = index;
              // bool loggedIn = Provider.of<ItemStore>(context, listen: false).loggedIn;
              //
              // if (index == 3 && loggedIn == false) {
              //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const Profile())));
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => (const GoogleSignInScreen())));
              //   _pageIndex = 0;
              // }
            },
          );
        },
      ),
    );
  }
}