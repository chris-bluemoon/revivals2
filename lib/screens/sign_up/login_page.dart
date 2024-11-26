import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Show a simple "___ Button Pressed" indicator
  void _showButtonPressDialog(BuildContext context, String provider) {
    log(provider);
  }

  /// Normally the signin buttons should be contained in the LoginPage
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SignInButtonBuilder(
          //   text: 'Get going with Email',
          //   icon: Icons.email,
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'Email');
          //   },
          //   backgroundColor: Colors.blueGrey[700]!,
          //   width: 220.0,
          // ),
          // const Divider(),
          SignInButton(
            mini: true,
            Buttons.Google,
            onPressed: () {
              _showButtonPressDialog(context, 'Google');
            
            },
          ),
          // const Divider(),
          // SignInButton(
          //   Buttons.GoogleDark,
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'Google (dark)');
          //   },
          // ),
          // const Divider(),
          // SignInButton(
          //   Buttons.FacebookNew,
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'FacebookNew');
          //   },
          // ),
          // const Divider(),
          SignInButton(
            Buttons.Apple,
            onPressed: () {
              _showButtonPressDialog(context, 'Apple');
            },
          ),
          // const Divider(),
          // SignInButton(
          //   Buttons.GitHub,
          //   text: "Sign up with GitHub",
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'Github');
          //   },
          // ),
          // const Divider(),
          // SignInButton(
          //   Buttons.Microsoft,
          //   text: "Sign up with Microsoft ",
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'Microsoft ');
          //   },
          // ),
          // const Divider(),
          // SignInButton(
          //   Buttons.Twitter,
          //   text: "Use Twitter",
          //   onPressed: () {
          //     _showButtonPressDialog(context, 'Twitter');
          //   },
          // ),
          // const Divider(),
        ],
      ),
    );
  }
}