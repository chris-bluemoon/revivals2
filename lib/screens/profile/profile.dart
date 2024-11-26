import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revivals/screens/profile/profile_landing.dart';
import 'package:revivals/shared/styled_text.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  ValueNotifier userCredential = ValueNotifier('');
  final FirebaseAuth auth = FirebaseAuth.instance;

  // @override
  // initState() {
    // getCurrentUser();
    // List<Renter> renters = Provider.of<ItemStore>(context, listen: false).renters;
    // log('Renters in Provider DB now:');
    // log(renters.length.toString());
    // super.initState();
  // }

  String uname = '----------';

  Future<dynamic> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
// Firebase.Auth.FirebaseUser user = auth.CurrentUser;
    // User? asda = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log('Setting uname: ${user.displayName}');
      uname = user.displayName.toString();
      // Insert user to Provider here?
    } else {
      log('Not logged in');
      signInWithGoogle();
      // const LoginPage();
    }
    return user;
    // return asda;
  }

  @override
  Widget build(BuildContext context) {
            double width = MediaQuery.of(context).size.width;

              final User? user = auth.currentUser;
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: width * 0.2,
        // centerTitle: true,
        title: const StyledTitle('PROFILE'),
      ),
        // TODO, is the valuelistener required?
        body: ProfileLanding(user, signOutFromGoogle)
    ); 
  }

}

Future<dynamic> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    // TODO
    print('exception->$e');
    log('exception->$e');
  }
}

Future<bool> signOutFromGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } on Exception catch (_) {
    return false;
  }
}

