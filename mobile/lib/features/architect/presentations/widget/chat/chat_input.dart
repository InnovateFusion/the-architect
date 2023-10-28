import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import '../../page/drawing/drawing.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    Key? key,
    required this.model,
    required this.onSubmitted,
    required this.onImagePick,
    required this.onControNet,
    required this.user
  }) : super(key: key);

  final String model;
  final void Function(BuildContext context, String text) onSubmitted;
  final User user;
  final void Function() onImagePick;
  final Future<void> Function(Map<String, dynamic> data) onControNet;

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
          GestureDetector(
            onTap: () async {
              if (model == 'image_to_image' ||
                  model == "image_variant" ||
                  model == "analysis" ||
                  model == "instruction") {
                onImagePick();
              } else if (model == "controlNet" || model == "edit_image") {
                {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Draw(user: user),
                    ),
                  );
                  if (result != null) {
                    onControNet(result);
                  }
                }
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                model == 'controlNet' || model == 'edit_image'
                    ? Icons.brush_outlined
                    : Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
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
