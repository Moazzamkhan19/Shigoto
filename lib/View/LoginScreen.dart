import 'package:flutter/material.dart';
import 'package:shigoto/View/DashboardScreen.dart';
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {return Scaffold(
    backgroundColor: const Color(0xFF4169E1), // Royal Blue background
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // Title Text
            const Text(
              "WELCOME TO SHIGOTO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 50),

            // White rounded container
            Container(
              width: 380,
              height: 500,
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
              //Text Fields
              child: Padding(padding: EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  TextField(
                      decoration:InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.blueGrey,fontSize: 20),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                  ),
                  SizedBox(height: 25,),
                  TextField(
                      decoration:InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.blueGrey,fontSize: 20),
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                  ),
                  SizedBox(height: 25,),

                  SizedBox(
                    width: 300,
                    height: 50,
                    child:
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, '/Dashboard');
                    },
                      child: Text("Login",
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ) ,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color(0xFF4169E1),
                      ),),
                  ),
                  SizedBox(height: 25,),
                  TextButton(onPressed: (){}, child: Text("Sign up",
                  style:TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),)),
                  Text("Powered by Flutter",style:
                    TextStyle(fontSize: 15,color: Colors.black26),),
                  Spacer(),
                ],
              ),)
              ),
            ],
        ),
        ),
      ),
  );

  }
}
