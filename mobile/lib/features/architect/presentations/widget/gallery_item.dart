import 'package:architect/features/architect/presentations/page/detail.dart';
import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({Key? key, required this.half}) : super(key: key);
  final bool half;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DetailPage())),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
          child: Image.asset(
            'assets/images/me.jpg',
            fit: BoxFit.cover,
            height: half ? 180 : 260,
          ),
        ),
      ),
    );
  }
}
