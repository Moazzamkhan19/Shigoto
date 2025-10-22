import 'package:flutter/material.dart';
import 'package:shigoto/View/LoginScreen.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {

  List<Map<String, dynamic>> projects = [
    {
      'project_name': 'Mobile App Redesign',
      'completion_rate': 0.75,
      'status': 'In Progress',
    },
    {
      'project_name': 'API Optimization',
      'completion_rate': 1.0,
      'status': 'Completed',
    },
    {
      'project_name': 'Database Migration',
      'completion_rate': 0.20,
      'status': 'On Hold',
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
  Widget _buildProjectItem(Map<String, dynamic> project, int index, Function onDelete) {
    final String name = project['project_name'] as String? ?? 'N/A';
    final double rate = project['completion_rate'] as double? ?? 0.0;
    final String status = project['status'] as String? ?? 'Unknown';

    return Dismissible(
      key: ValueKey(project['project_name'] ?? index),
      direction: DismissDirection.endToStart, // Slide from right to left
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
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status:', style: TextStyle(color: Colors.blueGrey)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              ],
            ),
          ),
        ),
      ),
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
            iconSize: 40,
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
                SizedBox(width: 120,),
                Icon(Icons.account_circle,size: 60,color: Colors.grey)
              ],
            )
          ),
          SizedBox(height: 35,),
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectItem(projects[index], index, (int i) {
                  setState(() {
                    projects.removeAt(i);
                  });
                });
              },
            )
          ),
        ],
      ),
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
