import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:revivals/shared/styled_text.dart';

class TypeBottomModal extends StatefulWidget {
  const TypeBottomModal(this.setType, {super.key});

  final Function setType;

  @override
  State<TypeBottomModal> createState() => _TypeBottomModalState();
}

class _TypeBottomModalState extends State<TypeBottomModal> {
  String selection = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    log('Building');

    return GestureDetector(
      child: Row(
        children: [
          const StyledBody('Product Type'),
          StyledBody(selection),
          const Icon(Icons.arrow_right),
        ],
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: Container(
                  child:
                  Column(children: [
                    ElevatedButton(
                      onPressed: () {
                        log('Calling setType');
                        widget.setType('Set');
                        Navigator.pop(context);}, 
                      child: const Text('Tap Me'))
                  ],)
                ),
              );
            });
      },
    );
     

  }

}
