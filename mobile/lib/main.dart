import 'package:architect/features/architect/presentations/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'injection_container.dart' as di;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
