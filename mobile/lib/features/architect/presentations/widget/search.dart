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
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: const Color(0xFFF4F0F3),
          border: Border.all(
            color: const Color(0xFFF4F0F3), // Border color
            width: 2.0, // Border width
          ),
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 25, // Example icon color
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  widget.onChanged(context, value);
                  searchController.clear();
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black, // Example text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
