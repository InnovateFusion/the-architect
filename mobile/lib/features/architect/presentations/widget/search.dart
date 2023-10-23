import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(String search) onPressed;

  const Search({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch() {
    String searchText = _searchController.text;
    widget.onPressed(searchText);
    _searchController.clear();
  }

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
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: _handleSearch,
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 25, // Example icon color
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onSubmitted: (value) => _handleSearch(),
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey, // Example hint text color
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
