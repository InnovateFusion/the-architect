import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import '../../page/history.dart';

class ChatItem extends StatelessWidget {
  final bool isSelected;
  final Function(int choice) onTap;
  final Icon icon;
  final String title;
  final int index;
  final User user;

  const ChatItem({
    Key? key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.user,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          onTap(index);
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => History(
                user: user
              ),
            ),
          );
        } else {
          onTap(index);
        }
      },
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
        ),
      ),
    );
  }
}
