import 'package:flutter/material.dart';

class React extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool isColor;
  final VoidCallback onPressed;

  const React({
    Key? key,
    required this.text,
    required this.isColor,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          child: icon,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
