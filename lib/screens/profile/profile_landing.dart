import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:revivals/screens/help_centre/faqs.dart';
import 'package:revivals/screens/profile/create_item.dart';
import 'package:revivals/screens/profile/messages/inbox.dart';
import 'package:revivals/screens/profile/my_account.dart';
import 'package:revivals/screens/profile/my_admin.dart';
import 'package:revivals/screens/profile/my_fittings.dart';
import 'package:revivals/screens/profile/my_items.dart';
import 'package:revivals/screens/profile/my_transactions.dart';
import 'package:revivals/screens/profile/settings.dart';
import 'package:revivals/screens/profile/verify_id.dart';
import 'package:revivals/screens/sign_up/google_sign_in.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/line.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:revivals/shared/whatsapp.dart';

class ProfileLanding extends StatefulWidget {
  const ProfileLanding(this.user, this.signOutFromGoogle, {super.key});

  final User? user;
  final Function() signOutFromGoogle;

  @override
  State<ProfileLanding> createState() => _ProfileLandingState();
}

class _ProfileLandingState extends State<ProfileLanding> {

  Future<void> shareApp() async {
    log('Sharing a link');
    const String appLink = 'https://my google play link';
    const String message = 'Check out my new app $appLink';
    await FlutterShare.share(
        title: 'Share App', text: message, linkUrl: appLink);
  }

  ValueNotifier userCredential = ValueNotifier('');

  cancelLogOut(context) async {
    Navigator.pop(context);
  }

  goBack(context) async {
    bool result = await widget.signOutFromGoogle();
    log('Pressed Exit 1');
    if (result) {
      log('awaited result and signed out');
      userCredential.value = '';
      Provider.of<ItemStore>(context, listen: false).setLoggedIn(false);
      // setState((context) {});
      // Navigator.pushReplacement<void, void>(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => const HomePage(),
      // ),
      Navigator.pop(context);
      setState(() {});
    }
    log('Pressed Exit 2');
  }
  
  bool admin = false;

  @override
  Widget build(BuildContext context) {
    // List<Item> allItems = Provider.of<ItemStore>(context, listen: false).items;
    String renterName = Provider.of<ItemStore>(context, listen: false).renter.name;
    if (renterName == 'uneartheduser' || renterName == 'CHRIS') {
      log('ADMIN user found');
      admin = true;
    }
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
        child: Consumer<ItemStore>(builder: (context, value, child) {
          if (Provider.of<ItemStore>(context, listen: false).loggedIn == true) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledHeading(
                    'PERSONAL (${Provider.of<ItemStore>(context, listen: false).renter.name})',
                    weight: FontWeight.normal,
                    color: Colors.grey),
                // Text('PERSONAL (${user!.displayName!})', style: const TextStyle(fontSize: 16)),
                SizedBox(height: width * 0.04),
                GestureDetector(
                  onTap: () {
                    String userN = Provider.of<ItemStore>(context, listen: false)
                        .renter
                        .name;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (MyAccount(userN))));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.account_circle_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('MY ACCOUNT', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const MyMessages())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.fact_check_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('MY MESSAGES', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const MyTransactions())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.fact_check_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('MY BOOKINGS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const MyFittings(false))));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.fact_check_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('MY FITTINGS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
      
                GestureDetector(
                  onTap: () {
                    shareApp();
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.group_add_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('REFER A FRIEND',
                          weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
      
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const Settings())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.settings_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('SETTINGS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                      Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
      
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const VerifyId())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.verified_user_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('VERIFY ID', weight: FontWeight.normal),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.06),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const CreateItem())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.image_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('CREATE ITEM', weight: FontWeight.normal),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.06),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const MyItems())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.image_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('MY ITEMS', weight: FontWeight.normal),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.06),
                const StyledHeading('SUPPORT',
                    weight: FontWeight.normal, color: Colors.grey),
                SizedBox(height: width * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => (const FAQs())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.help_outline, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('FAQ', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () {
                    // chatWithUsWhatsApp(context);
                    chatWithUsLine(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.chat_bubble_outline, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('CHAT WITH US', weight: FontWeight.normal),
                    ],
                  ),
                ),
                Divider(
                  height: width * 0.05,
                  indent: 50,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            setState(() {});
                            goBack(context);
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
                          child: StyledHeading("Successfully logged out",
                              weight: FontWeight.normal)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.exit_to_app, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('SIGN OUT', weight: FontWeight.normal),
                    ],
                  ),
                ),
                SizedBox(height: width * 0.04),
                Divider(
                  height: width * 0.1,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.black,
                ),
                if (admin) GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (const MyAdmin())));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.01),
                      Icon(Icons.description_outlined, size: width * 0.05),
                      SizedBox(width: width * 0.01),
                      const StyledBody('ADMIN', weight: FontWeight.normal),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (const GoogleSignInScreen())));
              },
              child: Row(
                children: [
                  SizedBox(width: width * 0.01),
                  Icon(Icons.login_outlined, size: width * 0.05),
                  SizedBox(width: width * 0.01),
                  const StyledBody('SIGN IN / CREATE ACCOUNT', weight: FontWeight.normal),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

// Send a LINE
void chatWithUsLine(BuildContext context) async {
  log('Tapped LINE send');
  try {
    await openLineApp(
      phone: '+65 91682725',
      text: 'Hello Unearthed Support...',
    );
  } on Exception catch (e) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(e.toString()),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}
// Send a Whatsapp
void chatWithUsWhatsApp(BuildContext context) async {
  log('Tapped whatsapp send');
  try {
    await openWhatsApp(
      phone: '+65 91682725',
      text: 'Hello Unearthed Support...',
    );
  } on Exception catch (e) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(e.toString()),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}

// showAlertDialog(BuildContext context) {
//   // Create button
//   Widget okButton = ElevatedButton(
//     child: const Center(child: Text("OK")),
//     onPressed: () {
//       // Navigator.of(context).pop();
//       log("Should be about to pop to first");
//       Navigator.of(context).popUntil((route) => route.isFirst);
//     },
//   );
//   // Create AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: const Center(child: Text("SIGNED OUT")),
//     // content: Text("      Your item is being prepared"),
//     actions: [
//       okButton,
//     ],
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(0.0)),
//     ),
//   );
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }



