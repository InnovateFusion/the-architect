import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({super.key});

  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {
  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: const LinearGradient(
        colors: [
          Color(0xFFD8E3E7),
          Color(0xFFC8D5DA),
          Color(0xFFD8E3E7),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: const LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 236, 238, 244),
            body: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 0.6,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle, width: 40, height: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 70, height: 30)),
                      SizedBox(width: 10),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 70, height: 30)),
                      SizedBox(width: 10),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 70, height: 30)),
                      SizedBox(width: 10),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 70, height: 30)),
                      SizedBox(width: 10),
                      SkeletonAvatar(
                          style: SkeletonAvatarStyle(width: 70, height: 30)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: SkeletonItem(
                            child: Column(
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 2,
                                  spacing: 6,
                                  padding: EdgeInsets.zero,
                                  lineStyle: SkeletonLineStyle(
                                      randomLength: true,
                                      height: 15,
                                      borderRadius: BorderRadius.circular(8),
                                      minLength:
                                          MediaQuery.of(context).size.width)),
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 30, height: 30)),
                                SizedBox(width: 15),
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 30, height: 30)),
                              ],
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
