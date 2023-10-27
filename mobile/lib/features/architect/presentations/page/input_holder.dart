import 'package:flutter/material.dart';

class InputHolder extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final Function(String text) onEdit;
  final String label;

  const InputHolder({
    super.key,
    required this.controller,
    required this.text,
    required this.onEdit,
    required this.label,
  });

  @override
  State<InputHolder> createState() => _InputHolderState();
}

class _InputHolderState extends State<InputHolder> {
  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: _isEditing
                ? TextField(
                    controller: widget.controller,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.label,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        widget.label == 'Password' ? '*******' : widget.text,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
          ),
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing && widget.controller.text.isNotEmpty) {
                  widget.onEdit(widget.controller.text);
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
    );
  }
}
