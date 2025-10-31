import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shigoto/View/DashboardScreen.dart';
import 'package:shigoto/View/TaskDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:shigoto/View/TeamMembersScreen.dart';
import 'package:shigoto/View/AnalyticsScreen.dart';
class Projectboardscreen extends StatefulWidget {
  const Projectboardscreen({super.key});

  @override
  State<Projectboardscreen> createState() => _ProjectboardscreenState();
}

class _ProjectboardscreenState extends State<Projectboardscreen> {
  int _selectedIndex = 0; // Keeps track of the current tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) { // 4 = Settings (0-based indexing)
      Navigator.pushNamed(context, '/Announcement');
    }
    else if (index == 3)
      {
        Navigator.pushReplacementNamed(context, '/Analytics');
      }
  }
  final List<Map<String, String>> tasks = [
    {"title": "Design login page"},
    {"title": "Assigned to All"},
    {"title": "Connect backend"},
    {"title": "Build landing page"},
    {"title": "Fix UI bugs"},
    {"title": "Deploy to server"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context,'/Dashboard');
        }, icon: Icon(Icons.arrow_back,size: 35,)),
      ),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Project Board ",textAlign:TextAlign.left,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              IconButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/TeamMember');
              },
                icon: Icon(Icons.group,size: 30,
                  color: Colors.blueAccent,),
              ),],
          ),
          SizedBox(height: 20,),
          Container(
            width: 380,
            height: 400,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(padding: EdgeInsets.all(12.0),
              child: GridView.builder(
                  itemCount: tasks.length,
                  gridDelegate:const
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,),
              itemBuilder: (context,index)
              {
                final task = tasks[index];
                return InkWell(
                  onTap:(){
                    Navigator.pushReplacementNamed(context, '/TaskDetail');
                  },
                  child: _buildCardView(task["title"]!),
                );
              }),

            ),
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 50,
                child:  ElevatedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, '/CreateTask');
                },child: Text("Add New Task",style:
                TextStyle(color: Colors.white,fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF4169E1),)),
              )

            ],
          )
        ],
      ),),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4169E1),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Project Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.lightBlueAccent,
      ),

    );
  }
  Widget _buildCardView(String title)
  {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 22,),
            Text(title,
            textAlign: TextAlign.center,
            style:  const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,)
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
