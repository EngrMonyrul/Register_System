import 'package:flutter/material.dart';
import 'package:loginsignup/auth_screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Times New Roman',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogInScreen(),
    );
  }
}
