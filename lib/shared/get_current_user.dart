import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

bool loggedIn = false;

Future getCurrentUser() async {
User? _user = await FirebaseAuth.instance.currentUser;
// Firebase.Auth.FirebaseUser user = auth.CurrentUser;
    // User? asda = FirebaseAuth.instance.currentUser;
    if(_user != null) {
      log('asda: ${_user.displayName}');
      loggedIn = true;
    } else {
      log('Not logged in');
      loggedIn = false;
    };
    return _user;
    // return asda;
  }