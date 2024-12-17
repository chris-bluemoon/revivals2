import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:revivals/shared/whatsapp.dart';


class MyAccount extends StatefulWidget {
  const MyAccount(this.userN, {super.key});

  final String userN;
  // final User? user;

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  

  late TextEditingController _addressController;
  late TextEditingController _phoneNumController;
  bool editingMode = false;

  String tempCountryField = '+66';

  @override
  void initState() {
    super.initState();
    String address = Provider.of<ItemStore>(context, listen: false).renter.address;
    String phoneNum = Provider.of<ItemStore>(context, listen: false).renter.phoneNum;
    _addressController = TextEditingController(text: address);
    _phoneNumController = TextEditingController(text: phoneNum);
    tempCountryField = Provider.of<ItemStore>(context, listen: false).renter.countryCode;
    // _aditemController = new TextEditingController(text: 'Initial value');
  }


  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    GlobalKey<FormState> formKey = GlobalKey();
    FocusNode focusNode = FocusNode();
    // String address = Provider.of<ItemStore>(context, listen: false).renters[0].address;

    // ValueNotifier userCredential = ValueNotifier('');
    SnackBar snackBar = SnackBar(
  content: const Center(child: Text('ACCOUNT SAVED', style: TextStyle(color: Colors.black, fontSize: 16))),
  backgroundColor: Colors.grey[100],
  behavior: SnackBarBehavior.fixed,
  duration: const Duration(seconds: 1)
  
//  shape: RoundedRectangleBorder
  //  (borderRadius:BorderRadius.circular(50),
      // ),
);

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: width * 0.2,
        centerTitle: true,
        title: const StyledTitle('ACCOUNT'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: width*0.08),
          onPressed: () {
            Navigator.pop(context);
          },
      ),),
      body: Padding(
        padding: EdgeInsets.fromLTRB(width * 0.05, width * 0.1, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledBody('NAME', color: (Colors.grey[600])!, weight: FontWeight.bold),
            TextFormField(
              style: TextStyle(fontSize: width*0.04),
              cursorColor: Colors.white,
              initialValue: widget.userN,
              // initialValue: 'John Doe',
              enabled: false,
            ),
              // value: Text('NAME: ${widget.user!.displayName!}', style: const TextStyle(fontSize: 14)),
            // ),
            const SizedBox(height: 30),
            StyledBody('EMAIL', color: (Colors.grey[600])!, weight: FontWeight.bold,),
            TextFormField(
              // initialValue: 'johndoe@gmail.com',
              // initialValue: widget.user!.email,
              style: TextStyle(fontSize: width*0.04),
              initialValue: Provider.of<ItemStore>(context, listen: false).renter.email,
              enabled: false,
            ),
            const SizedBox(height: 30),

            editingMode ? const StyledBody('ADDRESS') 
              : StyledBody('ADDRESS', color:(Colors.grey[600])!, weight: FontWeight.bold,),
                        TextFormField(
              style: TextStyle(fontSize: width*0.04),
              enableInteractiveSelection: false,
              decoration: const InputDecoration(        
              // counterText: '1111', 
              enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.grey),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                   ),  
             ),
              cursorColor: Colors.black,
              controller: _addressController,
              enabled: editingMode,
            ),
            const SizedBox(height: 30),

            editingMode ? const StyledBody('PHONE')
            // editingMode ? const Text('PHONE', style: TextStyle(fontSize: 12, color: Colors.black),) 
              :  StyledBody('PHONE', color: (Colors.grey[600])!, weight: FontWeight.bold,),

            // TextFormField(
            //   enableInteractiveSelection: false,
            //   decoration: const InputDecoration(        
            //   // counterText: '1111', 
            //   enabledBorder: UnderlineInputBorder(      
            //           borderSide: BorderSide(color: Colors.grey),   
            //           ),  
            //   focusedBorder: UnderlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey),
            //        ),  
            //  ),
            //   cursorColor: Colors.black,
            //   controller: _phoneNumController,
            //   enabled: editingMode,
            // ),
            Form(
      
        // key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//             IntlPhoneField(
//         dropdownTextStyle: editingMode ? const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal) 
//           : const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),
//     controller: _phoneNumController,
//     decoration: const InputDecoration(
//         labelText: 'Phone Number',
//         border: OutlineInputBorder(
//             borderSide: BorderSide(),
//         ),
//     ),
//     initialCountryCode: 'TH',
//     onChanged: (phone) {
//         print(phone.completeNumber);
//     },
// )
           IntlPhoneField(
              style: TextStyle(fontSize: width*0.04),
             initialCountryCode: 'TH',
             dropdownTextStyle: editingMode ? TextStyle(fontSize: width*0.04, color: Colors.black, fontWeight: FontWeight.normal) 
               : TextStyle(fontSize: width*0.04, color: Colors.grey, fontWeight: FontWeight.normal),
             showDropdownIcon: editingMode,
             controller: _phoneNumController,
             enabled: editingMode,
             textAlignVertical: const TextAlignVertical(y: 0),
             // focusNode: focusNode,
             decoration: const InputDecoration(
                             enabledBorder: UnderlineInputBorder(      
                     borderSide: BorderSide(color: Colors.grey),   
                     ),  
             focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey),
                  ),  
             ),
             languageCode: "en",
             onChanged: (phone) {
              
              // 
             },
             onCountryChanged: (country) {
              
               tempCountryField = country.name;
             },
           ),
           
            // MaterialButton(
            //   child: Text('Submit'),
            //   color: Theme.of(context).primaryColor,
            //   textColor: Colors.white,
            //   onPressed: () {
            //     _formKey.currentState?.validate();
            //   },
            // ),
          ],
        ),
    ),
            // PhoneField(),
          ],),
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
                if (!editingMode) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() { 
                        editingMode = true; 
                      });
                    },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black),
                      ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StyledHeading('EDIT', weight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                if (editingMode) Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                    formKey.currentState?.validate();
                    Renter toSave = Provider.of<ItemStore>(context, listen: false).renter;
                    toSave.address = _addressController.value.text;
                    toSave.phoneNum = _phoneNumController.value.text;
                    toSave.countryCode = tempCountryField;
                    Provider.of<ItemStore>(context, listen: false).saveRenter(toSave);
                    setState(() {
                      editingMode = false;
                    });
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
                      child: StyledHeading('SAVE', color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),   
    );
  }
}

  // String? validatePhoneNumber(String value) {
  //   if (value.length != 10) {
  //     return 'Mobile Number must be of 10 digit';
  //   } else {
  //     return null;
  //   }
  // }
  // Send a Whatsapp
void chatWithUsMessage(BuildContext context) async {
     
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
              child: Text(e.toString()
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          )
        );
      }
}

// showAlertDialog(BuildContext context) {  
//   // Create button  
//   Widget okButton = ElevatedButton(  
//     child: const Center(child: Text("OK")),  
//     onPressed: () {  
//       // Navigator.of(context).pop();  
//       Navigator.of(context).popUntil((route) => route.isFirst);
//     },  
//   ); 
//     // Create AlertDialog  
//   AlertDialog alert = AlertDialog(  
//     title: const Center(child: Text("SIGNED OUT")),
//     // content: Text("      Your item is being prepared"),  
//     actions: [  
//       okButton,  
//     ],  
//                 shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(0.0)),
//             ),
//   );  
//     showDialog(  
//     context: context,  
//     builder: (BuildContext context) {  
//       return alert;  
//     },  
//   );


// }