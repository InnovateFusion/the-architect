import 'package:architect/features/architect/presentations/bloc/auth/auth_bloc.dart';
import 'package:architect/features/architect/presentations/page/floatingButtonNav.dart';
import 'package:architect/features/architect/presentations/page/login.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  late AuthBloc authBloc = sl<AuthBloc>();
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    authBloc.add(AuthCheckEvent());
    authBloc.stream.listen((event) {
      if (event is Authenticated || event is AuthLogged) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FloatingNavigator(),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 238, 244),
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
            itemCount: demo_data.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
            itemBuilder: (context, index) => onboardingContent(
              title: demo_data[index].title,
              image: demo_data[index].image,
              note: demo_data[index].note,
            ),
          )),
          onBoardingNavigation(
              pageIndex: _pageIndex, pageController: _pageController),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
    required int pageIndex,
    required PageController pageController,
  }) : _pageIndex = pageIndex;

  final int _pageIndex;

  @override
  Widget build(BuildContext context) {
    return _pageIndex == demo_data.length - 1
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 80,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: const Color(0xff22c55e)),
                      child: const Text(
                        'Get Start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                // const Spacer(),
                ...List.generate(
                  demo_data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff22c55e),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 10 : 10,
      decoration: BoxDecoration(
          color: isActive ? const Color(0xff22c55e) : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  late final String title;
  late final String image;
  late final String note;

  Onboard({required this.title, required this.image, required this.note});
}

final List<Onboard> demo_data = [
  Onboard(
    title: 'The Architect',
    image: 'assets/images/onBoarding/start.png',
    note:
        "It's an AI-powered platform that empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
  ),
  Onboard(
    title: 'Inspirations',
    image: 'assets/images/onBoarding/Design Process-bro.svg',
    note:
        "The application should provide a design concept based on the architect's input on the needs of the client and other constraints like location, budget and also generate inspiration designs.",
  ),
  Onboard(
    title: 'Assistance ',
    image: 'assets/images/onBoarding/Creation process-cuate.svg',
    note:
        "AI-powered platform that assist and empowers professionals and enthusiasts in the field of architecture and design by offering a wide range of features and tools.",
  ),
  Onboard(
    title: 'Collaboration',
    image: 'assets/images/onBoarding/Team-bro.svg',
    note:
        'Collaboration is a key concept in various contexts. It involves individuals or groups working together to achieve common goals or complete tasks.',
  ),
  Onboard(
    title: 'Community',
    image: 'assets/images/onBoarding/Design tools-pana.svg',
    note:
        'The architecture community thrives on a spirit of collaboration, with architects globally sharing ideas, inspirations, and community to collectively shape the future of the built environment..',
  ),
];

class onboardingContent extends StatelessWidget {
  const onboardingContent(
      {super.key,
      required this.title,
      required this.image,
      required this.note});
  final String title;
  final String image;
  final String note;

  @override
  Widget build(BuildContext context) {
    return title == 'The Architect'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  image,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'WellCome',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          ' To',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'The',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff22c55e),
                          ),
                        ),
                        Text(
                          ' Architect',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff22c55e),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 40, bottom: 10),
                child: Text(
                  note,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontFamily: 'Urbanist-Light',
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          )
        : Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                    child: SvgPicture.asset(
                  image,
                )),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff22c55e),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  note,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Urbanist-Light',
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          );
  }
}
