import 'package:flutter/material.dart';

class FunctionForm extends StatefulWidget {
  const FunctionForm({
    required this.functionStyle,
    required this.selectedFunction,
    Key? key,
  }) : super(key: key);

  final Map<String, List<String>> functionStyle;
  final List<String> selectedFunction;

  @override
  State<FunctionForm> createState() => _FunctionFormState();
}

class _FunctionFormState extends State<FunctionForm> {
  void functionSelected(String key) {
    setState(() {
      if (widget.selectedFunction.isNotEmpty) {
        widget.selectedFunction.removeAt(0);
      }
      widget.selectedFunction.add(key);
    });
  }

  void functionUnselected(String key) {
    setState(() {
      widget.selectedFunction.remove(key);
    });
  }

  bool isSelected(String key) {
    return widget.selectedFunction.contains(key);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (String key in widget.functionStyle.keys)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    for (String value in widget.functionStyle[key]!)
                      GestureDetector(
                        onTap: () {
                          widget.selectedFunction.contains("$key $value")
                              ? functionUnselected("$key $value")
                              : functionSelected("$key $value");
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected("$key $value")
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Text(value, // Use value instead of key
                              style: TextStyle(
                                  color: isSelected("$key $value")
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                  ],
                )
              ],
            )
        ],
      ),
    );
  }
}
