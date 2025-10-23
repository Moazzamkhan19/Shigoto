import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  List<Map<String, String>> upcomings = [
    {
      "task": "Design App UI",
      "due": "25 Oct 2025",
      "status": "In Progress",
    },
    {
      "task": "Connect Backend",
      "due": "28 Oct 2025",
      "status": "Pending",
    },
    {
      "task": "Deploy to Server",
      "due": "2 Nov 2025",
      "status": "Not Started",
    },
    {
      "task": "Resolve Database Issue",
      "due": "24 Oct 2025",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Tasks"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4169E1),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/Dashboard');
          },
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: upcomings.length,
          itemBuilder: (context, index) {
            final upcoming = upcomings[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xFFEAF0FF), // very light blue shade
              margin: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  upcoming["task"]!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text("Due: ${upcoming["due"]}"),
                    const SizedBox(height: 2),
                    Text(
                      "Status: ${upcoming["status"]}",
                      style: TextStyle(
                        color: upcoming["status"] == "Completed"
                            ? Colors.green
                            : upcoming["status"] == "In Progress"
                            ? Colors.orange
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
               /* trailing: const Icon(Icons.arrow_forward_ios, size: 18),*/
              ),
            );
          },
        ),
      ),
    );
  }
}

