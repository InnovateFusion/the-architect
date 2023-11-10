import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:architect/features/architect/presentations/bloc/user/user_bloc.dart';
import 'package:architect/features/architect/presentations/page/login.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();

  static const String name = '/signup';
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _countryController;
  late bool _isObscure;
  late bool _isEmailValid;
  late bool _isPasswordValid;
  late bool _isFormValid;
  late User user;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _isEmailValid = false;
    _isPasswordValid = false;
    _isFormValid = false;
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _countryController = TextEditingController();
    _firstNameController.addListener(_onFormChanged);
    _lastNameController.addListener(_onFormChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _countryController.addListener(_onFormChanged);
  }

  void _onEmailChanged() {
    final email = _emailController.text;
    setState(() {
      _isEmailValid = email.contains('@');
    });
    _onFormChanged();
  }

  void _onPasswordChanged() {
    final password = _passwordController.text;
    setState(() {
      _isPasswordValid = password.length >= 8;
    });
    _onFormChanged();
  }

  void _onFormChanged() {
    setState(() {
      _isFormValid = _isEmailValid && _isPasswordValid;
    });
  }

  void _onSignUpButtonPressed(BuildContext context) {
    if (_isFormValid) {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final country = _countryController.text;
      if (firstName == '' || lastName == '') {
        return;
      }
      BlocProvider.of<UserBloc>(context).add(CreateUserEvent(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        country: country,
        image: '',
        bio: '',
      ));
    }
  }

  void _onToggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void showAboutDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(child: Text('User already exists')),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext cnt) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 238, 244),
      body: SafeArea(
        child: input(context),
      ),
    );
  }

  SingleChildScrollView input(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        child: BlocProvider(
          create: (context) => sl<UserBloc>(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/logo.svg',
                                height: 90, width: 90),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Text(
                                  "The",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Architect",
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        hintText: 'First Name',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Last Name',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: const OutlineInputBorder(),
                        errorText: _isEmailValid || _emailController.text == ''
                            ? null
                            : 'Invalid email',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _emailController.clear();
                          },
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelStyle: const TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: _onToggleObscure,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocConsumer<UserBloc, UserState>(
                      listener: (contx, state) {
                        if (state is UserCreated) {
                          Navigator.push(
                              contx,
                              MaterialPageRoute(
                                  builder: (contx) => const Login()));
                        }
                        if (state is UserError) {
                          showAboutDialog(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const SizedBox(
                              height: 70, child: LoadingIndicator());
                        } else {
                          return Column(
                            children: [
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff22c55e),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onPressed: () {
                                    _onSignUpButtonPressed(context);
                                  },
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      )),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
