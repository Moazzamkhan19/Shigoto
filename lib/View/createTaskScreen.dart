import 'package:flutter/material.dart';
import 'package:shigoto/Components/MyDropDownFIeld.dart';
import 'package:shigoto/Components/MyTextFields.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final Map<String, dynamic> assigneeData = {
    "All": Icons.people_outline,
    "Naveed": "assets/images/naveed.png",
    "Moazzam": "assets/images/moazzam.png",
    "Huzaifa": "assets/images/huzaifa.png",
  };
  String? selectedAssignee;

  final Map<String, IconData> statusData = {
    "Pending": Icons.hourglass_bottom_outlined,
    "In Progress": Icons.update_outlined,
  };
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.04),
            const Padding(
              padding: EdgeInsets.only(left: 33),
              child: Text(
                "Create Task",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: Container(
                width: 330,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FB),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.015),
                    const Text(
                      'Task 1',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Mytextfields(
                      label: "Title",
                      controller: titleController,
                      icon: Icons.edit_note_outlined,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Mytextfields(
                      label: "Description",
                      controller: descController,
                      icon: Icons.description_outlined,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    const Text(
                      'Assignee',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    MyDropdownField(
                      value: selectedAssignee,
                      hint: "Select Assignee",
                      itemDisplay: assigneeData,
                      onChanged: (val) {
                        setState(() {
                          selectedAssignee = val;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    MyDropdownField(
                      value: selectedStatus,
                      hint: "Select Status",
                      itemDisplay: statusData,
                      onChanged: (val) {
                        setState(() {
                          selectedStatus = val;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4169E1),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Create Task',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
