import 'package:flutter/material.dart';
import 'package:shigoto/Components/MyTextFields.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  final TextEditingController nameController = TextEditingController();

  static const String _settingsImagePath = 'assets/images/settingVector.png';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: const Color(0xFF4169E1),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Dashboard');
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          iconSize: 30,
        ),
      ),
      body: Column(
        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            color: const Color(0xFF4169E1),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                _settingsImagePath,
                fit: BoxFit.contain, // Ensures the whole image is visible
                height: 300, // You can adjust the height as needed
              ),
            ),
          ),
          // ------------------------------------

          // --- White Settings Content Area ---
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView( // Added SingleChildScrollView for safety
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile Settings",
                      style: TextStyle(
                        fontSize: 22, // Increased font size for title
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // --- SET PROFILE ---
                    Row(children: [
                      Text("Set Profile Picture",style:TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                      SizedBox(width: 150,),
                      IconButton(onPressed: (){
                        //SETTING PROFILE CODE
                      }, icon: Icon(Icons.account_circle,size: 40,))
                    ],),

                    // --- Dark Mode Switch ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Dark Mode",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          value: isDarkMode,
                          activeColor: const Color(0xFF4169E1),
                          onChanged: (value) {
                            setState(() {
                              isDarkMode = value;
                              // You would typically update the app's theme here
                            });
                          },
                        ),
                      ],
                    ),
                    // --------------------------

                    const SizedBox(height: 40),

                    // --- Delete Profile Button ---
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5, // Add some elevation
                        ),
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text(
                          "Delete Profile",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // -----------------------------
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //shows dialouge box for deletion
  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter Password'),
                //we need to call the validate method to validate password then
                //proceed with deletion
                SizedBox(height: 15,),
                Mytextfields(label: "Password")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {

                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

}