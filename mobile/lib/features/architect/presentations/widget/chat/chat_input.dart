import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key, required this.onSubmitted}) : super(key: key);

  final void Function(BuildContext context, String text) onSubmitted;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    void handleSubmitted(String text) {
      onSubmitted(context, text);
      textController.clear();
    }

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
                color: const Color.fromARGB(255, 0, 0, 0),
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
          Expanded(
            child: TextField(
              controller: textController,
              onSubmitted: handleSubmitted,
              decoration: const InputDecoration(
                hintText: "Send a message",
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => handleSubmitted(
              textController.text,
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.send_outlined,
                size: 40,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
