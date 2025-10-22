import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shigoto/View/DashboardScreen.dart';
import 'package:shigoto/View/TaskDetail.dart';
import 'package:flutter/cupertino.dart';
class Projectboardscreen extends StatefulWidget {
  const Projectboardscreen({super.key});

  @override
  State<Projectboardscreen> createState() => _ProjectboardscreenState();
}

class _ProjectboardscreenState extends State<Projectboardscreen> {
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
              SizedBox(width: 60,),
              Icon(Icons.group,size: 50,color: Colors.blueAccent,)
              //projectboard screen->add team members -> generates a link to join to share
            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: 380,
            height: 500,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color:Colors.white,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign,color:Colors.white,),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month,color:Colors.white,),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color:Colors.white,),
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
