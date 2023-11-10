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
              color: selected
                  ? const Color.fromARGB(255, 142, 231, 175)
                  : const Color.fromARGB(255, 210, 215, 228),
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
