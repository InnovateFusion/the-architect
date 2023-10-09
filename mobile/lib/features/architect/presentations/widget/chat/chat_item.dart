import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function(int) onTap;
  final Icon icon;
  final String title;
  final Widget body;

  const ChatItem({
    Key? key,
    required this.title,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.body,
  }) : super(key: key);

  void showPopUp(BuildContext context, String text, {Widget? body}) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (_) => Dialog(
          child: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 400,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 181, 178, 179),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: body ??
                      const Text(
                        "No body",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                ),
              ]),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
        showPopUp(context, title, body: body);
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
