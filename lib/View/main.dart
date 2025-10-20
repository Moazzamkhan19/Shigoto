import 'package:flutter/material.dart';
import 'package:shigoto/View/SplashScreen.dart';
import 'package:shigoto/View/LoginScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*home: const SplashScreen(),
      routes: {
        '/login': (context) => const Loginscreen(),
      },
       */
      home: const Loginscreen(),
    );
  }
}



