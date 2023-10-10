import 'package:flutter/material.dart';

class PomptTag extends StatefulWidget {
  const PomptTag({
    required this.pomptTagStyle,
    required this.selectedPomptTag,
    Key? key,
  }) : super(key: key);

  final List<String> pomptTagStyle;
  final List<String> selectedPomptTag;

  @override
  State<PomptTag> createState() => _PomptTagState();
}

class _PomptTagState extends State<PomptTag> {
  void pomptTagSelected(String key) {
    setState(() {
      if (widget.selectedPomptTag.isNotEmpty) {
        widget.selectedPomptTag.removeAt(0);
      }
      widget.selectedPomptTag.add(key);
    });
  }

  void pomptTagUnselected(String key) {
    setState(() {
      widget.selectedPomptTag.remove(key);
    });
  }

  bool isSelected(String key) {
    return widget.selectedPomptTag.contains(key);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Wrap(
        children: [
          for (String key in widget.pomptTagStyle)
            GestureDetector(
              onTap: () {
                widget.selectedPomptTag.contains(key)
                    ? pomptTagUnselected(key)
                    : pomptTagSelected(key);
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected(key) ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Text(key,
                    style: TextStyle(
                        color: isSelected(key) ? Colors.white : Colors.black)),
              ),
            ),
        ],
      ),
    );
  }
}
