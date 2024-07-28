import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> itemList;
  final String selectedValue;
  final void Function(String?) onChanged;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;

  const MyDropdownMenu({
    super.key,
    required this.itemList,
    required this.selectedValue,
    required this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: itemList.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      value: selectedValue,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      onTap: onTap,
    );
  }
}
