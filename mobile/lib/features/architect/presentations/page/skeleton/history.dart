import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HistoryShimmer extends StatefulWidget {
  const HistoryShimmer({super.key});

  @override
  State<HistoryShimmer> createState() => _HistoryShimmerState();
}

class _HistoryShimmerState extends State<HistoryShimmer> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 70,
                          width: MediaQuery.of(context).size.width - 110,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 70,
                          width: 70,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 140,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (var i = 0; i < 15; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                  borderRadius: BorderRadius.circular(15),
                                  height: 70,
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
