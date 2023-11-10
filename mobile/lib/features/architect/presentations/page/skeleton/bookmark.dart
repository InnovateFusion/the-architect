import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class BooKMarkShimmer extends StatefulWidget {
  const BooKMarkShimmer({super.key});

  @override
  State<BooKMarkShimmer> createState() => _BooKMarkShimmerState();
}

class _BooKMarkShimmerState extends State<BooKMarkShimmer> {
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 236, 238, 244),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.75,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (var i = 0; i < 10; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: i % 2 == 0 ? 260 : 180,
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: i % 2 == 0 ? 260 : 180,
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
