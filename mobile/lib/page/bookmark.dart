import 'package:architect/widget/custom_bottom_navigation.dart';
import 'package:architect/widget/gallery_item.dart';
import 'package:architect/widget/profile_image.dart';
import 'package:flutter/material.dart';

class BookMark extends StatelessWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bookmarks",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Capturing Moments",
                            style: TextStyle(
                              color: Color(0xFF9F9C9E),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      ProfileImage(
                          imageUrl: 'assets/images/me.jpg', size: 50.0),
                    ],
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                              GalleryItem(half: true),
                              GalleryItem(half: false),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 40,
              right: 40,
              child: CustomBottomNavigation(currentNav: 3),
            ), // Add custom bottom navigation
          ],
        ),
      ),
    );
  }
}
