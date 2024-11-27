import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/auth.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/constants.dart';
import 'package:revivals/shared/loading.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({required this.toggleView, super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool found = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = 'Error: ';

  bool ready = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void handleFoundLogIn(String email) {
      Provider.of<ItemStore>(context, listen: false).setLoggedIn(true);
      List<Renter> renters =
          Provider.of<ItemStore>(context, listen: false).renters;
      found = false;
      log(renters.toString());
      for (Renter r in renters) {
        if (r.email == email) {
          found = true;
          log('Found email in renters: $email');
          Provider.of<ItemStore>(context, listen: false).setCurrentUser();
        } 
      }
      if (found == false) {
        log('User found in Google but not in database! Fix!');
      }
      // if (found == false) {
      //   log('Did not find an existing user, adding');
      //   String jointUuid = uuid.v4();
      //   Provider.of<ItemStore>(context, listen: false).addRenter(Renter(
      //     id: jointUuid,
      //     email: email,
      //     name: 'CHRIS',
      //     size: 0,
      //     address: '',
      //     countryCode: '+66',
      //     phoneNum: '',
      //     favourites: [''],
      //     fittings: [],
      //     settings: ['BANGKOK', 'CM', 'CM', 'KG'],
      //   ));
      //   Provider.of<ItemStore>(context, listen: false).assignUser(Renter(
      //     id: jointUuid,
      //     email: email,
      //     name: 'CHRIS',
      //     size: 0,
      //     address: '',
      //     countryCode: '+66',
      //     phoneNum: '',
      //     favourites: [''],
      //     fittings: [],
      //     settings: ['BANGKOK', 'CM', 'CM', 'KG'],
      //   ));
      // }
    Provider.of<ItemStore>(context, listen: false).populateFavourites();
    Provider.of<ItemStore>(context, listen: false).populateFittings();
    }

    return loading ? const Loading() : Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        // centerTitle: true,
        title: const StyledTitle('SIGN IN'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width * 0.08),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: width * 0.02),
            child: GestureDetector(
              onTap: () {
                widget.toggleView();
              },
              child: Row(
                children: [
                  const StyledBody('REGISTER', weight: FontWeight.normal),
                  SizedBox(width: width * 0.01),
                  Icon(Icons.person, size: width * 0.05)
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StyledHeading(
              'Enter your email and password',
              weight: FontWeight.normal,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                              ready = true;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                            validator: (val) => val!.length < 6
                                ? 'Enter a password at least 6 chars long'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                                ready = true;
                              });
                            }),
            SizedBox(height: width * 0.05),
            GestureDetector(
              onTap: () async {
                bool res = await _auth.sendPasswordReset(email);
                log('res is: ${res.toString()}');
                if (res == false) {
                  showAlertDialogError(context);
                }
              },
              child: const StyledBody('Forgotten password?')),
                      ],
                    ))),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                if (!ready) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('SIGN IN', weight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (ready) Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                                       if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    log('RESULT: ${result.toString()}');
                    if (result == null) {
                      setState(() => loading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          actions: [
                            // ElevatedButton(
                            // onPressed: () {cancelLogOut(context);},
                            // child: const Text('CANCEL', style: TextStyle(color: Colors.black)),),
                            ElevatedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  backgroundColor:
                                      const WidgetStatePropertyAll<Color>(
                                          Colors.black),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0)),
                                          side: BorderSide(
                                              color: Colors.black)))),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                });
                                // goBack(context);
                              },
                              child: const StyledHeading(
                                'OK',
                                weight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          backgroundColor: Colors.white,
                          title: const Center(
                              child: StyledHeading("Error Signing In",
                                  weight: FontWeight.normal)),
                        ),
                      );
                              setState(() {
                                log('Setting password to nothing');
                                _formKey.currentState!.reset();
                              });
                    } else {
                      handleFoundLogIn(email);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  }
                    ready = false;
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('SIGN IN', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }
  showAlertDialogError(BuildContext context) {
    // Create button
    double width = MediaQuery.of(context).size.width;

    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(-1.0),
        ),
        side: const BorderSide(width: 0.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: StyledBody("OK", color: Colors.white)),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: StyledHeading('EMAIL NOT FOUND')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('Please check email',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('and try again',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
     showAlertDialog(BuildContext context) {
    // Create button
    double width = MediaQuery.of(context).size.width;

    Widget okButton = ElevatedButton(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.white),
        foregroundColor: Colors.white, //change background color of button
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(-1.0),
        ),
        side: const BorderSide(width: 0.0, color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: const Center(child: StyledBody("OK", color: Colors.white)),
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: StyledHeading('PASSWORD RESET SENT')),
      content: SizedBox(
        height: width * 0.1,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('Check your registered',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledBody('email to reset password',
                    weight: FontWeight.normal),
                // Text("Your $itemType is being prepared,"),
                // Text("please check your email for confirmation."),
              ],
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(-1.0)),
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
