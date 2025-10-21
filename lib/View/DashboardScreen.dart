import 'package:flutter/material.dart';

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
  Widget _buildProjectItem(Map<String, dynamic> project) {
    final String name = project['project_name'] as String? ?? 'N/A';
    final double rate = project['completion_rate'] as double? ?? 0.0;
    final String status = project['status'] as String? ?? 'Unknown';

    return Card(
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Adjusted padding
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.15), // Adjusted opacity
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0
                    ),
                  ),
                ),
              ],
            ),
          ],
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
            onPressed: () {},
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
            child: Text(
              "Dashboard",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectItem(projects[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Color(0xFF4169E1),
      ),
    );
  }
}
