import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:flutter/material.dart';
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
    const Icon(Icons.imagesearch_roller),
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
    "Image to Image",
    "Controller",
    "Painting",
    "Variants",
    "Text to 3D",
    "Chat Bot",
    "Analytics",
  ];

  List<String> modelsX = [
    "new_chat",
    "history",
    "text_to_image",
    "image_to_image",
    "controlNet",
    "painting",
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
