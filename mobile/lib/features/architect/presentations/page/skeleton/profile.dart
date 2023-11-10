import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ProfileShimmer extends StatefulWidget {
  const ProfileShimmer({super.key});

  @override
  State<ProfileShimmer> createState() => _ProfileShimmerState();
}

class _ProfileShimmerState extends State<ProfileShimmer> {
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
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 210,
                        child: Stack(
                          children: [
                            const SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              width: double.infinity,
                              height: 170,
                            )),
                            Positioned(
                              bottom: 0,
                              right: MediaQuery.of(context).size.width * 0.35,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 236, 238, 244),
                                    width: 8,
                                  ),
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: const SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      shape: BoxShape.circle,
                                      width: 90,
                                      height: 90),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 35,
                                width: 100,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          const SizedBox(width: 30),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 35,
                                width: 100,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 20,
                                width: MediaQuery.of(context).size.width * 0.6,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 40,
                                width: 120,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.51,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
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
