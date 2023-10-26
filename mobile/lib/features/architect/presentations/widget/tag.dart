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
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
