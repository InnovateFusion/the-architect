import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(BuildContext context, String value) onChanged;

  const Search({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search ",
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(189, 189, 189, 1),
                  fontSize: 14,
                ),
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 12, bottom: 12), // Add padding here
                border: InputBorder.none,
                suffixIcon: Container(
                  width: 50,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xff22c55e),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      widget.onChanged(context, searchController.text);
                    },
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 7))
        ],
      ),
    );
  }
}
