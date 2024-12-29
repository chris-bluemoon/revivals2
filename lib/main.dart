// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:revivals/screens/help_centre/faqs.dart';
import 'package:revivals/screens/help_centre/how_it_works.dart';
import 'package:revivals/screens/help_centre/sizing_guide.dart';
import 'package:revivals/screens/help_centre/who_are_we.dart';
import 'package:revivals/screens/home_page.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/theme.dart';

import 'firebase_options.dart';

void main() async {
  // Firebase initialize
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    // name: "revivals dev project",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ItemStore(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/faqs': (context) => const FAQs(),
        '/howItWorks': (context) => const HowItWorks(),
        '/whatIs': (context) => const WhoAreWe(),
        '/sizingGuide': (context) => const SizingGuide(),
        // '/dateAddedItems': (context) => const DateAddedItems(),
      },
    ),
  ));
}
