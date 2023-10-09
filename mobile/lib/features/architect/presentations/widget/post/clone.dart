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
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(22.5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(
          Icons.cyclone,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
