import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: const Color(0xFFB8B9BD)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xFFB8B9BD),
                borderRadius: BorderRadius.circular(25)),
            child: const Icon(
              Icons.attach_file_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.black, // Example text color
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.send_outlined,
              size: 40,
              color: Color(0xFFB8B9BD),
            ),
          )
        ],
      ),
    );
  }
}
