import 'package:flutter/material.dart';

List<String> list = <String>['Dress', 'Hat', 'Bag'];

class DropdownType extends StatefulWidget {

  const DropdownType(this.callback, {super.key});

  final Function(String) callback;


  @override
  State<DropdownType> createState() => _DropdownTypeState();
}
class _DropdownTypeState extends State<DropdownType> {
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