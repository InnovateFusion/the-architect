import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:flutter/material.dart';

import '../../domains/entities/user.dart';
import '../page/bookmark.dart';
import '../page/chat.dart';
import '../page/drawing/drawing.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentNav;
  final User user;

  const CustomBottomNavigation({
    Key? key,
    required this.user,
    this.currentNav = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: const Color.fromARGB(255, 10, 6, 1).withOpacity(0.9),
      ),
      height: 70, // Set the height of the bottom navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (currentNav == 0)
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
            )
          else
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFFA2A09D),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          if (currentNav == 1)
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {},
              ),
            )
          else
            IconButton(
              icon: const Icon(
                Icons.chat,
                color: Color(0xFFA2A09D),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat(
                              user: user,
                            )));
              },
            ),
          if (currentNav == 2)
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.draw),
                onPressed: () {},
              ),
            )
          else
            IconButton(
              icon: const Icon(
                Icons.draw,
                color: Color(0xFFA2A09D),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Draw()));
              },
            ),
          if (currentNav == 3)
            Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.bookmark),
                onPressed: () {},
              ),
            )
          else
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Color(0xFFA2A09D),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookMark(
                      user: user,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
