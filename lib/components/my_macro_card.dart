import 'package:flutter/material.dart';

class MyMacroCard extends StatelessWidget {
  const MyMacroCard(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.style,
      this.icon});
  final Color backgroundColor;
  final String text;
  final TextStyle style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 4),
            Text(
              text,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
