import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final VoidCallback onPressed;

  const Search({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 23, // Example icon color
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey, // Example hint text color
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
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
