import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function(int) onTap;
  final Widget icon;

  const ChatItem({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 181, 178, 179),
              borderRadius: BorderRadius.circular(20)),
          child: IconTheme(
            data: IconThemeData(
                color: isSelected ? Colors.white : Colors.black, size: 20),
            child: icon,
          )),
    );
  }
}
