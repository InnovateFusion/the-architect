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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.black
            : const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: isSelected
              ? const Color.fromARGB(255, 255, 255, 255)
              : Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => onPressed(text),
        child: Text(
          capitalizeAll(text),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
