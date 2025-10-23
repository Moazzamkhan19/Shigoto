import 'package:flutter/material.dart';
import 'package:shigoto/View/AnalyticsScreen.dart';
import 'package:shigoto/View/SplashScreen.dart';
import 'package:shigoto/View/TeamMembersScreen.dart';
import 'package:shigoto/View/createTaskScreen.dart';
import 'package:shigoto/View/LoginScreen.dart';
import 'package:shigoto/View/DashboardScreen.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';
import 'package:shigoto/View/TaskDetail.dart';
import 'package:shigoto/View/settings_screen.dart';

import 'View/SignupScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // start normally
      routes: {
        '/login': (context) => const Loginscreen(),
        '/Dashboard': (context) => const Dashboardscreen(),
        '/ProjectBoard': (context) => const Projectboardscreen(),
        '/CreateTask': (context) => CreateTaskScreen(),
        '/TaskDetail': (context)=>Taskdetail(),
        '/TeamMember': (context) => TeamMemberScreen(),
        '/Analytics': (context) => AnalyticsScreen(),
        '/Settings':(context)=> SettingsScreen(),
        '/Signup':(context)=> SignupScreen(),
      },
    );
  }
}
