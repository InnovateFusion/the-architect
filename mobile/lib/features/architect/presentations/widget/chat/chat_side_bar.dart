import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:flutter/material.dart';

import '../../page/ChatInfo.dart';
import 'chat_item.dart';

class ChatSideBar extends StatefulWidget {
  final String selectedModel;
  final User user;
  final void Function(int index) onModelChanged;

  const ChatSideBar({
    Key? key,
    required this.selectedModel,
    required this.user,
    required this.onModelChanged,
  }) : super(key: key);

  @override
  State<ChatSideBar> createState() => _ChatSideBarState();
}

class _ChatSideBarState extends State<ChatSideBar> {
  List<Icon> icons = [
    const Icon(Icons.add_circle_outline),
    const Icon(Icons.history_outlined),
    const Icon(Icons.text_format_outlined),
    const Icon(Icons.image_outlined),
    const Icon(Icons.integration_instructions),
    const Icon(Icons.control_point_duplicate_outlined),
    const Icon(Icons.draw_outlined),
    const Icon(Icons.view_array_outlined),
    const Icon(Icons.threed_rotation_outlined),
    const Icon(Icons.chat_bubble_outline),
    const Icon(Icons.analytics_outlined),
  ];

  List<String> titles = [
    "New Chat",
    "History",
    "Text to Image",
    "Image from Text",
    'Instrution',
    "Controller",
    "Edit Image",
    "Variants",
    "Text to 3D",
    "Chat Bot",
    "Analytics",
  ];

  List<String> modelsX = [
    "new_chat",
    "history",
    'image_from_text',
    "image_to_image",
    "instruction",
    "controlNet",
    "edit_image",
    "image_variant",
    "text_to_3D",
    "chatbot",
    "analysis",
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: 40,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatInfo(
                    user: widget.user,
                  ),
                ),
              ),
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 210, 215, 228),
                    borderRadius: BorderRadius.circular(20)),
                child: const IconTheme(
                  data: IconThemeData(color: Colors.black, size: 20),
                  child: Icon(Icons.info_outline,
                      color: Color.fromARGB(255, 0, 0, 0), size: 20),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                if (index == 2) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: ChatItem(
                      user: widget.user,
                      index: index,
                      icon: icons[index],
                      title: titles[index],
                      isSelected:
                          widget.selectedModel == modelsX[index] && index > 1,
                      onTap: widget.onModelChanged,
                    ),
                  );
                } else {
                  return ChatItem(
                    user: widget.user,
                    index: index,
                    icon: icons[index],
                    title: titles[index],
                    isSelected:
                        widget.selectedModel == modelsX[index] && index > 1,
                    onTap: widget.onModelChanged,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
