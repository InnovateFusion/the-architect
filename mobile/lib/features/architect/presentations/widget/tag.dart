import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(String word) onPressed;

  const Tag({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onPressed,
  });
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  String capitalizeAll(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.split(' ').map((e) => capitalize(e)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xff22c55e)
            : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => onPressed(text),
        child: Text(
          capitalizeAll(text),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
