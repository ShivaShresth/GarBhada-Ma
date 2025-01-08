// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Drop_Btn extends StatefulWidget {
  final List<dynamic> items;
  final String? selectedItemText;
  final Function(String?) onItemSelected;

  Drop_Btn({
    Key? key,
    required this.items,
    this.selectedItemText,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<Drop_Btn> createState() => _Drop_BtnState();
}

class _Drop_BtnState extends State<Drop_Btn> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 120,
      padding: EdgeInsets.only(left: 5, right: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: DropdownButton(
        hint: Text("Selected Items"),
        iconSize: 20,
        value: selectedValue,
        style: TextStyle(color: Colors.black, fontSize: 12),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue?.toString();
            widget.onItemSelected(selectedValue);
          });
        },
        items: widget.items.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem.toString()),
          );
        }).toList(),
      ),
    );
  }
}
