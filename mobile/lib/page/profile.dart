import 'package:architect/widget/gallery_item.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 170,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: AssetImage("assets/images/me.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                    Positioned(
                      top: 120,
                      right: deviceWidth / 2 - 50 - 10,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 7,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 100,
                        width: 100,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          child: Image(
                            image: AssetImage("assets/images/me.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Jhon Doe",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Embrace the glorious mess that you are",
                  style: TextStyle(
                    color: Color(0xFF9F9C9E),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "144 K",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Color(0xFF9F9C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Text(
                          "574",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                            color: Color(0xFF9F9C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Text(
                          "139",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Posts",
                          style: TextStyle(
                            color: Color(0xFF9F9C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
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
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
