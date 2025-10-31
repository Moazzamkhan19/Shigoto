import 'package:flutter/material.dart';
import 'package:shigoto/View/LoginScreen.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';
import 'package:shigoto/Components/MyTextFields.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  int _selectedIndex = 0; // Keeps track of the current tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 4) { // 4 = Settings (0-based indexing)
      Navigator.pushReplacementNamed(context, '/Settings');
    }
    else if (index == 1) {
      _buildAddProjectDialogBox();
    }
    else if (index == 2) {
      _JoinTeamDialogBox();
    }
    else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/Upcoming');
    }
  }

  List<Map<String, dynamic>> projects = [
    {
      'project_name': 'Mobile App Redesign',
      'completion_rate': 0.75,
      'status': 'In Progress',
      'SDate': '15-07-25',
      'EDate': '15-07-25',
    },
    {
      'project_name': 'API Optimization',
      'completion_rate': 1.0,
      'status': 'Completed',
      'SDate': '15-07-25',
      'EDate': '15-07-25',
    },
    {
      'project_name': 'Database Migration',
      'completion_rate': 0.20,
      'status': 'On Hold',
      'SDate': '15-07-25',
      'EDate': '15-07-25',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      case 'on hold':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildProjectItem(BuildContext context,
      Map<String, dynamic> project,
      int index,
      Function onDelete,) {
    final String name = project['project_name'] as String? ?? 'N/A';
    final double rate = project['completion_rate'] as double? ?? 0.0;
    final String status = project['status'] as String? ?? 'Unknown';
    final String sdate = project['SDate'] as String? ?? 'Nill';
    final String edate = project['EDate'] as String? ?? 'Nill';

    return Dismissible(
      key: ValueKey(project['project_name'] ?? index),
      direction: DismissDirection.endToStart,
      // Slide from right to left
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDelete(index); // Call callback to remove item from list
      },
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/ProjectBoard');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.97,
          // reduce width
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Project Name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  // Progress bar + %
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LinearProgressIndicator(
                          value: rate,
                          backgroundColor: Colors.grey[300],
                          color: rate == 1.0 ? Colors.green : Colors.blue,
                          minHeight: 8.0,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${(rate * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10.0),

                  // Status Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: _getStatusColor(status),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10.0),

                  // Dates Row (responsive)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Start date: $sdate",
                          style: const TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "End date: $edate",
                          style: const TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _buildAddProjectDialogBox() async {
    TextEditingController projectNameController = TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFD6E0FF),
          title: const Text("Add Project"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start Date Picker Row
              Row(
                children: [
                  const Text("Start Date:", style: TextStyle(fontSize: 17)),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        startDate = picked;
                      }
                    },
                    child: const Text("Select",style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),

              // End Date Picker Row
              Row(
                children: [
                  const Text("End Date:", style: TextStyle(fontSize: 17)),
                  const SizedBox(width: 18),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        endDate = picked;
                      }
                    },
                    child: const Text("Select",style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Project Name Field
              Mytextfields(
                label: "Project Name",
                icon: Icons.work,
                controller: projectNameController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(
                color: Colors.black
              ),),
            ),
            TextButton(
              onPressed: () {
                print("Start Date: $startDate");
                print("End Date: $endDate");
                print("Project Name: ${projectNameController.text}");
                Navigator.pop(context);
              },
              child: const Text("Add",style: TextStyle(
                color: Colors.black
              ),),
            ),
          ],
        );
      },
    );
  }
  void _JoinTeamDialogBox() async {
    TextEditingController code = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFD6E0FF),
          title: const Text("Join Project Team"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Name Field
              Mytextfields(
                label: "Enter Team Code",
                controller: code,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(
                color: Colors.black,
              ),),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Join",style:TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            iconSize: 30,
          ),
    ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Title
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Row(
              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 40,),
                Icon(Icons.account_circle,size: 60,color: Colors.grey)
              ],
            )
          ),
          SizedBox(height: 25,),
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectItem(context, projects[index], index, (int i) {
                  setState(() {
                    projects.removeAt(i);
                  });
                });
                ;
              },
            )
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4169E1),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color:Colors.white,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded,color:Colors.white,),
            label: 'Add Project',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add,color:Colors.white,),
          label: 'Join',),
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
}
