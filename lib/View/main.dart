import 'package:flutter/material.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';
import 'package:shigoto/View/SplashScreen.dart';
import 'package:shigoto/View/LoginScreen.dart';
import 'package:shigoto/View/DashboardScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: const SplashScreen(),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/Dashboard': (context) => const Dashboardscreen(),
        '/ProjectBoard':(context)=>const Projectboardscreen(),
      }
      /*home: const Loginscreen(),*/
      /* home: const Dashboardscreen(),*/

    );
  }
}



