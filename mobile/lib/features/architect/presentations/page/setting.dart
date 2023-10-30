import 'dart:convert';
import 'dart:io';

import 'package:architect/core/util/get_image_base64.dart';
import 'package:architect/features/architect/presentations/bloc/user/user_bloc.dart';
import 'package:architect/features/architect/presentations/page/about_page.dart';
import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:architect/features/architect/presentations/page/input_holder.dart';
import 'package:architect/features/architect/presentations/page/login.dart';
import 'package:architect/features/architect/presentations/page/premier.dart';
import 'package:architect/features/architect/presentations/page/privacy.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/user.dart';
import '../bloc/auth/auth_bloc.dart';

class Setting extends StatefulWidget {
  const Setting({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<Setting> createState() => _SettingState();
  static const String name = '/setting';
}

class _SettingState extends State<Setting> {
  late AuthBloc authBloc;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(text: 'Password');

  String firstName = '';
  String lastName = '';
  String bio = '';
  String password = 'Password';

  String base64ImageForImageToImage = '';
  String orginalImage = '';
  String orginalImageBase64 = '';
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    authBloc = sl<AuthBloc>();
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    bio = widget.user.bio;
    orginalImage = widget.user.image;
  }

  Future<void> startImage() async {
    orginalImageBase64 = await getImageAsBase64(orginalImage) ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onFisrtNameEdit(String text) {
    setState(() {
      firstName = text;
    });
  }

  void onLastNameEdit(String text) {
    setState(() {
      lastName = text;
    });
  }

  void onBioEdit(String text) {
    setState(() {
      bio = text;
    });
  }

  void onPasswordEdit(String text) {
    setState(() {
      bio = text;
    });
  }

  Future<void> submit(BuildContext context) async {
    if (firstName != widget.user.firstName ||
        lastName != widget.user.lastName ||
        bio != widget.user.bio ||
        base64ImageForImageToImage.isNotEmpty) {
      () {
        BlocProvider.of<UserBloc>(context).add(
          UpdateUserEvent(
            id: widget.user.id,
            firstName: firstName,
            lastName: lastName,
            email: widget.user.email,
            password: password,
            image: base64ImageForImageToImage.isNotEmpty
                ? base64ImageForImageToImage
                : orginalImageBase64,
            bio: bio,
            country: widget.user.country,
          ),
        );
      }();
      Navigator.popUntil(context, (route) {
        return route.runtimeType == HomePage;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<String> imageToBase64(String imagePath) async {
    final File imageFile = File(imagePath);

    if (await imageFile.exists()) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } else {
      return '';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      imagePath = pickedImage.path;
    });
    imagePath = pickedImage.path;
    base64ImageForImageToImage = await imageToBase64(pickedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 40,
                      child: GestureDetector(
                        onTap: () {
                          submit(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(imagePath.isEmpty
                              ? widget.user.image
                              : imagePath)),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 181, 178, 179),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  bio,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputHolder(
                        controller: _firstNameController,
                        text: firstName,
                        onEdit: onFisrtNameEdit,
                        label: 'First Name',
                      ),
                      InputHolder(
                        controller: _lastNameController,
                        text: lastName,
                        onEdit: onLastNameEdit,
                        label: 'Last Name',
                      ),
                      InputHolder(
                          controller: _bioController,
                          text: bio,
                          onEdit: onBioEdit,
                          label: 'Bio'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PremierPage(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: Colors.black,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Premier',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutPage(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'About',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPage(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.privacy_tip_outlined,
                                color: Colors.black,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: GestureDetector(
                      onTap: () {
                        authBloc.add(AuthLogoutEvent());
                        authBloc.stream.listen((event) {
                          if (event is AuthLoggedOut) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                              (route) => false,
                            );

                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            );
                          } else {
                            const LoadingIndicator();
                          }
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
