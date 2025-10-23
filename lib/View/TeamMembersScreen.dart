import 'package:flutter/material.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({super.key});

  @override
  State<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {
  final List<Member> members = [
    Member(name: "Naveed", taskCount: 6, profileImageUrl: "assets/images/naveed.png"),
    Member(name: "Huzaifa", taskCount: 7, profileImageUrl: "assets/images/huzaifa.png"),
    Member(name: "Moazzam", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Mom", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Mzam", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Moaam", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Moazzm", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Moazam", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Moazamad", taskCount: 7, profileImageUrl: "assets/images/moazzam.png"),
    Member(name: "Mzzam", taskCount: 7, profileImageUrl: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/ProjectBoard');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 33),
            child: Text(
              "Team Members",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              height: 500,
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                    child: Dismissible(
                      key: Key(member.name),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          members.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${member.name} removed')),
                        );
                      },
                      child: Card(
                        color: const Color(0xFFF5F7FB),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          leading: member.profileImageUrl == null
                              ? CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.blue,
                            child: Text(
                              member.name[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              : CircleAvatar(
                            radius: 34,
                            backgroundImage: AssetImage(member.profileImageUrl!),
                          ),
                          title: Text(
                            member.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('${member.taskCount} tasks'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4169E1),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Add Member",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Member {
  final String name;
  final int taskCount;
  final String? profileImageUrl;

  Member({
    required this.name,
    required this.taskCount,
    this.profileImageUrl,
  });
}
