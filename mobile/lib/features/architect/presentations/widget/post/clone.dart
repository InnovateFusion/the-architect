import 'package:flutter/material.dart';

class Clone extends StatelessWidget {
  final Color color;
  final void Function() onPressed;

  const Clone({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(27.5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: const Icon(
          Icons.cyclone,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
