import 'package:flutter/material.dart';
import 'package:shigoto/Components/MyDropDownFIeld.dart';
import 'package:shigoto/Components/MyTextFields.dart';

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
    "Completed": Icons.check_circle_outline,
  };
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 33),
            child: Text(
              "Create Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 45),
          Center(
            child: Container(
              height: 600,
              width: 330,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FB),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Task 1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Mytextfields(
                    label: "Title",
                    controller: titleController,
                    icon: Icons.edit_note_outlined,
                  ),
                  SizedBox(height: 20),
                  Mytextfields(
                    label: "Description",
                    controller: descController,
                    icon: Icons.description_outlined,
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Assignee',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 40),
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 30,),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  )

                ],
              ),
            ),
          ),

        ],
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
