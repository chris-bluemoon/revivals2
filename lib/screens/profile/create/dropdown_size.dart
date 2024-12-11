import 'package:flutter/material.dart';

List<String> list = <String>['4', '6', '8', '10'];

class DropdownSize extends StatefulWidget {

  const DropdownSize(this.callback, {super.key});

  final Function(String) callback;


  @override
  State<DropdownSize> createState() => _DropdownSizeState();
}
class _DropdownSizeState extends State<DropdownSize> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
            onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.callback(dropdownValue);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}