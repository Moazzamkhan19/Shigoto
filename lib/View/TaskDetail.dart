import 'package:flutter/material.dart';

class Taskdetail extends StatefulWidget {
  const Taskdetail({super.key});

  @override
  State<Taskdetail> createState() => _TaskdetailState();
}

class _TaskdetailState extends State<Taskdetail> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0)
    {
      Navigator.pushNamed(context, '/Dashboard');
    }
    else if (index == 1)
    {
      Navigator.pushReplacementNamed(context, '/Upcoming');
    }
    else
    {
      Navigator.pushReplacementNamed(context, '/Settings');
    }
  }
  // Your comments list remains the same
  List<Map<String, String>> comments = [
    {
      'name': 'Moazzam',
      'tasks': '5',
      'position': 'Team Lead',
      'comment': 'Doing great progress on the project.'
    },
    {
      'name': 'Ali',
      'tasks': '3',
      'position': 'UI Designer',
      'comment': 'Working on login screen design.'
    },
    {
      'name': 'Awais',
      'tasks': '4',
      'position': 'Backend Developer',
      'comment': 'API integration is in progress.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Safely get the first comment data, or an empty map if the list is empty
    final firstComment = comments.isNotEmpty
        ? comments[0]
        : <String, String>{
      'name': 'No Comment',
      'tasks': '0',
      'position': '',
      'comment': 'No comments available.'
    };
    final commentName = firstComment['name'] ?? 'U';
    final initial = commentName.isNotEmpty ? commentName[0] : 'U';

    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/ProjectBoard');
          },
          icon: const Icon(Icons.arrow_back, size: 35),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start, // left align outer column
          children: [
            const Text(
              "Task Detail",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Card(
              color: const Color(0xB3FFFFFF),
              child: Container(
                width: double.infinity, // <-- Makes card take full width
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // left align inner content
                  children: [
                    const Text(
                      "Design Login Page",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDEEFF),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "In-Progress",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDEEFF),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Assigned to All",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 55),
                    const Text(
                      "Re-Designing Login Screen",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            // The Row containing the buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Edit Task",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Comment",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
            // The original ListView.builder code has been removed.
            // The SizedBox(height: 20,) was also inside the Row and has been removed.
            const SizedBox(height: 20), // Add spacing after buttons

            // --- Displaying a single Card (the first comment) instead of a list ---
            Card(
              color: const Color(0xB3FFFFFF),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    initial,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  commentName,
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Position: ${firstComment['position']}'),
                    Text('Tasks: ${firstComment['tasks']}'),
                    const SizedBox(height: 4),
                    Text(
                      '"${firstComment['comment']}"',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          ],
        ),
      ),
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
            icon: Icon(Icons.calendar_month),
            label: 'Upcoming',
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
}
