import 'package:flutter/material.dart';

import '../../domains/entities/post.dart';
import '../page/detail.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({Key? key, required this.half, required this.post})
      : super(key: key);
  final bool half;
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            post: post,
                          )));
            },
            child: Image.network(
              post.image,
              fit: BoxFit.cover,
              height: half ? 180 : 260,
            ),
          ),
        ),
      ),
    );
  }
}
