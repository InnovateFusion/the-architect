import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData? iconData;
  final Widget? child;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;

  const IconBox({
    Key? key,
    this.iconData,
    this.child,
    this.tooltip,
    required this.selected,
    required this.onTap,
  })  : assert(child != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 181, 178, 179),
              borderRadius: BorderRadius.circular(20)),
          child: Tooltip(
            message: tooltip,
            preferBelow: false,
            child: child ??
                Icon(
                  iconData,
                  color: selected
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : Colors.grey[900],
                  size: 20,
                ),
          ),
        ),
      ),
    );
  }
}
