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
          title:  Text("Do An Announcement"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Mytextfields(
                label: "Enter Announcement",
                controller: code,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Done",
                style: TextStyle(color: Colors.black),
              ),
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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,size: 35,)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color:  Color(0xFFEAF0FF),
              margin:  EdgeInsets.only(bottom: 15),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  announcement["text"]!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Padding(
                  padding:  EdgeInsets.only(top: 5.0),
                  child: Text(
                    announcement["time"]!,
                    style: TextStyle(color: Colors.grey),
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
             SnackBar(content: Text("Add new announcement!")),
          );
        },
        backgroundColor:  Color(0xFF4169E1),
        child: Icon(Icons.add, size: 30,color: Colors.white,),
      ),
    );
  }
}

