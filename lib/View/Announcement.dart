import 'package:flutter/material.dart';

import '../Components/MyTextFields.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  List<Map<String, String>> announcements = [
    {
      "text": "Team meeting scheduled for Monday 10 AM.",
      "time": "Today, 8:30 AM"
    },
    {
      "text": "Server maintenance completed successfully.",
      "time": "Yesterday, 5:45 PM"
    },
    {
      "text": "New feature rollout planned for next week.",
      "time": "22 Oct 2025, 9:00 AM"
    },
    {
      "text": "Please submit project updates by tomorrow.",
      "time": "21 Oct 2025, 6:00 PM"
    },
  ];

  void _AnnoucementDialogBox() async {
    TextEditingController code = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFD6E0FF),
          title: const Text("Do An Annoucement"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Mytextfields(
                label: "Enter Annoucement",
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
              child: const Text("Done",style:TextStyle(
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
        title: const Text("Announcements"),
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
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
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
                  announcement["text"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    announcement["time"]!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _AnnoucementDialogBox();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add new announcement!")),
          );
        },
        backgroundColor: const Color(0xFF4169E1),
        child: const Icon(Icons.add, size: 30,color: Colors.white,),
      ),
    );
  }
}

