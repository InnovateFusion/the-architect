import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ShimmerHome extends StatefulWidget {
  const ShimmerHome({super.key});

  @override
  State<ShimmerHome> createState() => _ShimmerState();
}

class _ShimmerState extends State<ShimmerHome> {
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
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 20,
                          width: 100,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.circle, width: 40, height: 40),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.94,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Row(
                  children: [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 70, height: 30)),
                    SizedBox(width: 10),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 70, height: 35)),
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.76,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8.0),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: SkeletonItem(
                          child: Column(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: double.infinity,
                              minHeight: MediaQuery.of(context).size.height / 8,
                              maxHeight: MediaQuery.of(context).size.height / 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 3,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength:
                                      MediaQuery.of(context).size.width / 2,
                                )),
                          ),
                          const SizedBox(height: 8),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
