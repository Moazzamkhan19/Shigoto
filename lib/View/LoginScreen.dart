import 'package:flutter/material.dart';
import 'package:shigoto/View/DashboardScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4169E1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vector image
                Image.asset(
                  "assets/images/loginVector.png",
                  width: 300,
                  height: 300,
                ),

                const SizedBox(height: 20),

                // White container with text fields and buttons
                Container(
                  height: 500,
                  width: 380,  // container width
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email field
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password field
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      // Login Button
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/Dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4169E1),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // OR Divider
                      Row(
                        children: const [
                          Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('OR'),
                          ),
                          Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Google Sign-in Button
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      // Sign Up row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/Signup');
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )

          ),
        ),
      ),
    );
  }
}
