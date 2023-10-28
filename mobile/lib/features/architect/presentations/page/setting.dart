import 'dart:io';

import 'package:architect/features/architect/presentations/page/input_holder.dart';
import 'package:architect/features/architect/presentations/page/login.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    authBloc = sl<AuthBloc>();
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    bio = widget.user.bio;
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
                          Navigator.of(context).pop();
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
                          image: FileImage(File(widget.user.image)),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
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
                      InputHolder(
                          controller: _passwordController,
                          text: password,
                          onEdit: onPasswordEdit,
                          label: "Password")
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
                        const Row(
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
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                              (Route<dynamic> route) => false,
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
