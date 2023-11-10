import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class TeamShimmer extends StatefulWidget {
  const TeamShimmer({super.key});

  @override
  State<TeamShimmer> createState() => _TeamShimmerState();
}

class _TeamShimmerState extends State<TeamShimmer> {
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
                Column(
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
                  ],
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < 10; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SkeletonLine(
                            style: SkeletonLineStyle(
                                height: 130,
                                width: MediaQuery.of(context).size.width * 0.3),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 320,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (var i = 0; i < 10; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                  borderRadius: BorderRadius.circular(15),
                                  height: 80,
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
