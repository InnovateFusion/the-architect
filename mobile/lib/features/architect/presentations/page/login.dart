import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:architect/features/architect/presentations/bloc/auth/auth_bloc.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isObscure;
  late bool _isEmailValid;
  late bool _isPasswordValid;
  late bool _isFormValid;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _isEmailValid = false;
    _isPasswordValid = false;
    _isFormValid = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
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
      _isPasswordValid = password.length >= 6;
    });
    _onFormChanged();
  }

  void _onFormChanged() {
    setState(() {
      _isFormValid = _isEmailValid && _isPasswordValid;
    });
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_isFormValid) {
      final email = _emailController.text;
      final password = _passwordController.text;
      BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(
        email: email,
        password: password,
      ));
    }
  }

  void _onToggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext cnt) {
    return BlocProvider<AuthBloc>(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLogged || state is Authenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthInitial) {
                return input(context);
              } else if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthError) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  SingleChildScrollView input(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            Image.asset('assets/images/logo.png', width: 150),
            const SizedBox(height: 32),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'email',
                border: const OutlineInputBorder(),
                errorText: _isEmailValid || _emailController.text == ''
                    ? null
                    : 'Invalid email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'password',
                border: const OutlineInputBorder(),
                errorText: _isPasswordValid || _passwordController.text == ''
                    ? null
                    : 'Invalid password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _onToggleObscure,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _onLoginButtonPressed(context);
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
