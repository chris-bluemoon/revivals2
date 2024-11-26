import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:revivals/models/renter.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  Renter? _userFromFirebaseUser(User? user) {
    return user != null ? Renter(id: user.uid,
      email: 'Anon',
      name: 'anon',
      size: 0,
      address: '',
      countryCode: '+66',
      phoneNum: '',
      favourites: [''],
      fittings: [''],
      settings: ['BANGKOK','CM','CM','KG'],
    ) : null;
  }
  // Sign in anon
  Future signInAnon() async {
    try {
      // FirebaseUser user = (await FirebaseAuth.instance.
// signInWithEmailAndPassword(email: email, password: password))
// .user;
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      log("Sign in error: $e");
      return null;
    }
  }

  // Register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      log('User creation successful');
      log('Returning${_userFromFirebaseUser(user)}');
      return _userFromFirebaseUser(user);
    } catch(e) {
      log('User creation error ${e.toString()}');
      return null;
    }
  }

  // Register with email
  Future sendPasswordReset(String email) async {
    log('Sending password reset to email: $email');
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch(e) {
      log('Possible email not found: ${e.toString()}');
      return false;
    }
  }

  // Sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      log(result.toString());
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      log('User sign in error ${e.toString()}');
      return null;
    }

  }


  // Sign out
}