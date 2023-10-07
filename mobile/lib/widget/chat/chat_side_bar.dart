import 'package:architect/widget/chat/chat_item.dart';
import 'package:flutter/material.dart';

class ChatSideBar extends StatefulWidget {
  const ChatSideBar({Key? key}) : super(key: key);

  @override
  _ChatSideBarState createState() => _ChatSideBarState();
}

class _ChatSideBarState extends State<ChatSideBar> {
  List<Icon> icons = [
    const Icon(Icons.landscape),
    const Icon(Icons.view_in_ar_outlined),
    const Icon(Icons.rectangle_outlined),
    const Icon(Icons.ads_click_rounded),
    const Icon(Icons.build_circle_outlined),
    const Icon(Icons.cyclone),
  ];

  int selectedIndex = 0;

  Widget xx = SizedBox(
    width: 40,
    height: 40,
    child: PopupMenuButton(
      icon: const Icon(Icons.bubble_chart_outlined),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ValueListenableBuilder<double>(
              valueListenable: ValueNotifier(0),
              builder: (context, value, _) {
                return Column(children: [
                  const Text(
                    'Stroke Size',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 6, 6, 6),
                        fontWeight: FontWeight.w600),
                  ),
                  Slider(
                    value: value,
                    min: 0,
                    max: 50,
                    label: '${value.toInt()}',
                    activeColor: const Color.fromARGB(255, 119, 116, 116),
                    inactiveColor: const Color.fromARGB(255, 203, 198, 198),
                    onChanged: (val) {},
                  ),
                ]);
              },
            ),
          ),
        ];
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Column(
          children: [
            for (int i = 0; i < icons.length; i++)
              ChatItem(
                index: i,
                isSelected: i == selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                icon: icons[i],
              ),
          ],
        ),
      ],
    ));
  }
}
