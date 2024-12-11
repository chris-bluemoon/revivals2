import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:revivals/shared/styled_text.dart';

class TypeBottomModal extends StatefulWidget {
  const TypeBottomModal({super.key});

  @override
  State<TypeBottomModal> createState() => _TypeBottomModalState();
}

class _TypeBottomModalState extends State<TypeBottomModal> {
  String selection = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log('Building');

   setValue(value) {
    setState() {
    selection = value;
    }
   } 
    return GestureDetector(
      child: Row(
        children: [
          StyledBody('Product Type'),
          StyledBody(selection),
          Icon(Icons.arrow_right),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Container(
                  child: 
                    GestureDetector(
                      child: Text('Tap Here'),
                      onTap: () {
                        log('tapped');
                        setState() {
                          setValue('New Value');
                        }
                      }),
                ),
              );
            });
      },
    );
     

  }

}
