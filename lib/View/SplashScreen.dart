import 'package:flutter/material.dart';
import 'dart:async';

import 'LoginScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');

      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginscreen()),
      );*/

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4169E1),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Text(
            'SHIGOTO',
            style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 5,
              fontFamily: 'ArialRoundedMTBold',
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.white.withOpacity(0.4),
                  offset: const Offset(0, 0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

