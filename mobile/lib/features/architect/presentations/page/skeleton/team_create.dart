import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class TeamCreateShimmer extends StatefulWidget {
  const TeamCreateShimmer({super.key});

  @override
  State<TeamCreateShimmer> createState() => _TeamCreateShimmerState();
}

class _TeamCreateShimmerState extends State<TeamCreateShimmer> {
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 236, 238, 244),
                            width: 8,
                          ),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              shape: BoxShape.circle, width: 90, height: 90),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40)),
                          const SizedBox(height: 15),
                          SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                  width: MediaQuery.of(context).size.width,
                                  height: 90)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 35)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.43,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (var i = 0; i < 8; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                  borderRadius: BorderRadius.circular(15),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width),
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
