import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  const ErrorDisplay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.network_check_rounded,
          size: 40,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        const SizedBox(height: 10),
        Text(
          message,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
