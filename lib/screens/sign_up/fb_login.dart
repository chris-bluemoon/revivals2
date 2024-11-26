import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FBLogin {
  
Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken);
    String accessToken = 'b24206bccc56a4134c620c211fe09d57';
    // final facebookAuthCredential = FacebookAuthProvider.credential(accessToken);
    final facebookAuthCredential = FacebookAuthProvider.credential(accessToken);
    log('Access token');
    log('Access toekn: $result.accessToken');

    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

  }
}
