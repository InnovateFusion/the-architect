import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double textSize;
  final VoidCallback onPressed;

  const Tag({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
