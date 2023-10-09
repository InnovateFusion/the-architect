import 'package:architect/features/architect/presentations/widget/post/user_info.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
            body: SizedBox(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(children: [
                    SizedBox(
                      height: 435,
                      child: Image.asset('assets/images/me.jpg',
                          fit: BoxFit.cover),
                    ),
                    const Positioned(
                        top: 10,
                        right: 10,
                        child: UserInfo(
                            name: 'Rizky',
                            date: '2 hours ago',
                            imageUrl: 'assets/images/me.jpg')),
                  ]),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E0E4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(child: Text('Home'))),
                    const SizedBox(width: 10),
                    Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E0E4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(child: Text('Interior'))),
                    const SizedBox(width: 10),
                    Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E0E4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(child: Text('Room'))),
                  ],
                ),
                const SizedBox(height: 15),
                const Text("Lorem ipsum dolor sit amet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies aliquam, nisl nisl aliquet nisl, quis aliquam nisl nisl eget nisl. Donec auctor, nisl eget ultricies aliquam, nisl nisl aliquet nisl, quis aliquam nisl nisl eget nisl.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ]),
        ),
      ),
    )));
  }
}
