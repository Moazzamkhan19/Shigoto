import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shigoto/View/LoginScreen.dart';
import 'package:shigoto/View/ProjectBoardScreen.dart';
import 'package:shigoto/Components/MyTextFields.dart';
import 'package:shigoto/Controller/Authentication.dart';
import 'package:shigoto/Model/Project_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../Controller/ProjectController.dart';
class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  Authentication aut=Authentication();

  late String currentUserId;
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
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId = user.uid;
    } else {
      // Handle not-signed-in case, maybe redirect to login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  Widget _buildProjectItem(
      BuildContext context,
      ProjectModel project,
      int index,
      Function onDelete,
      ) {
    final String name = project.projectTitle;
    final String status = project.status;
    final String sdate = "${project.startDate.toLocal()}".split(' ')[0];
    final String edate = "${project.endDate.toLocal()}".split(' ')[0];

    // Placeholder for completion (will be dynamic once tasks are implemented)
    final double rate = 0.5;

    final Projectcontroller projectController = Projectcontroller();

    return Dismissible(
      key: ValueKey(project.projectId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) async {
        // Call controller to delete project
        String result = await projectController.deleteProject(
          userid: FirebaseAuth.instance.currentUser!.uid,
          projectid: project.projectId,
        );

        // Show feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );

        // Remove from local list (StreamBuilder handles UI refresh)
        onDelete(index);
      },
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            '/ProjectBoard',
            arguments: project,
          );
        },
        onLongPress: () {
          _showUpdateProjectDialog(context, project);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.97,
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
                children: [
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
                    children: [
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
                  const SizedBox(height: 10.0),

                  // Dates Row
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
    TextEditingController projectDescriptionController = TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    String selectedstatus = "In Progress";
    final Projectcontroller projectController = Projectcontroller();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD6E0FF),
          title: const Text("Add Project"),
          content: SingleChildScrollView(
            child: Column(
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
                          setState(() {
                            startDate = picked;
                          });
                        }
                      },
                      child: const Text(
                        "Select",
                        style: TextStyle(color: Colors.black),
                      ),
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
                          setState(() {
                            endDate = picked;
                          });
                        }
                      },
                      child: const Text(
                        "Select",
                        style: TextStyle(color: Colors.black),
                      ),
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
                SizedBox(height: 10,),
                Mytextfields(
                  label: "Project Description",
                  icon: Icons.description,
                  controller: projectDescriptionController,
                ),
                SizedBox(height: 8,),
                SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: selectedstatus,
                  decoration: InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    "In Progress",
                    "On Hold",
                    "Completed",
                  ].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedstatus = value!;
                  },
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Validation
                if (projectNameController.text.isEmpty ||
                    projectDescriptionController.text.isEmpty ||
                    startDate == null ||
                    endDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                // Call addProject
                final result = await projectController.addProject(
                  projectTitle: projectNameController.text,
                  description: projectDescriptionController.text,
                  startdate: startDate!,
                  enddate: endDate!,
                  ownerid: currentUserId, // Ensure this is non-null
                  status: selectedstatus, // default status
                );

                // Feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );

                // Close dialog
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.black),
              ),
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
  Widget profileDialogBox(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    final user = FirebaseAuth.instance.currentUser;

    Future<void> pickAndUploadImage() async {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user logged in!')),
        );
        return;
      }

      // Pick image from gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected!')),
        );
        return;
      }

      File file = File(image.path);

      // Validate file
      if (!file.existsSync() || file.lengthSync() == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid image selected!')),
        );
        return;
      }

      // Debug info
      print('File path: ${file.path}');
      print('File exists: ${file.existsSync()}, size: ${file.lengthSync()} bytes');

      try {
        final storageRef =
        FirebaseStorage.instance.ref().child('users/${user.uid}.jpg');

        print('Uploading to: ${storageRef.fullPath}');

        // Start upload and wait for completion safely
        final snapshot = await storageRef.putFile(file);

        print('Upload state: ${snapshot.state}');

        if (snapshot.state == TaskState.success) {
          // Upload succeeded, now get download URL
          final imageUrl = await snapshot.ref.getDownloadURL();
          print('Download URL: $imageUrl');

          // Update Firebase Auth profile
          await user.updatePhotoURL(imageUrl);
          await user.reload();

          // Update Firestore user document
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'photoUrl': imageUrl});

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          throw Exception('Upload did not succeed: ${snapshot.state}');
        }
      } on FirebaseException catch (e) {
        print('FirebaseException: ${e.code} - ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('FirebaseException: ${e.code} - ${e.message}')),
        );
      } catch (e) {
        print('Other exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    }

    return AlertDialog(
      title: const Text('Update Profile Picture'),
      content: GestureDetector(
        onTap: pickAndUploadImage,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : null,
          child: user?.photoURL == null
              ? const Icon(Icons.person, size: 50)
              : null,
          backgroundColor: Colors.white38,
          foregroundColor: Colors.blueAccent,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  void _showUpdateProjectDialog(BuildContext context, ProjectModel project) {
    final titleController = TextEditingController(text: project.projectTitle);
    final descController = TextEditingController(text: project.description);

    // 👇 This is NEW
    String selectedStatus = project.status ?? "In Progress";

    Projectcontroller projectcontroller = Projectcontroller();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Project"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Project Title"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(labelText: "Description"),
              ),
              SizedBox(height: 10),

              // 👇 ADD STATUS DROPDOWN HERE
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                items: [
                  "In Progress",
                  "On Hold",
                  "Completed",
                ].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedStatus = value!;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await projectcontroller.updateProject(
                  projectId: project.projectId,
                  projectTitle: titleController.text.trim(),
                  description: descController.text.trim(),
                  status: selectedStatus, // 👈 NOW accessible
                );

                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
// To show the dialog:
  void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => profileDialogBox(context),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Projectcontroller projectController = Projectcontroller();

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            onPressed: () {
              aut.fullLogout();
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
          buildDashboardHeader(context), // <-- NEW CLEAN HEADER
          SizedBox(height: 10),

          // Project List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('projects')
                  .where('ownerId', isEqualTo: currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No projects found."));
                }

                List<ProjectModel> projects = snapshot.data!.docs
                    .map((doc) =>
                    ProjectModel.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    return _buildProjectItem(
                      context,
                      project,
                      index,
                          (int i) async {
                        await projectController.deleteProject(
                          userid: currentUserId,
                          projectid: project.projectId,
                        );
                      },
                    );
                  },
                );
              },
            ),
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
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded, color: Colors.white),
            label: 'Add Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.white),
            label: 'Join',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.white),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.lightBlueAccent,
      ),
    );
  }
  Widget buildDashboardHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.all(20),
        // 🔥 Responsive height (instead of fixed 231)
        height: MediaQuery.of(context).size.height * 0.25,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4169E1),
              Color(0xFF5A7BFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
          image: DecorationImage(
            image: AssetImage("assets/images/work_objects.png"),
            fit: BoxFit.contain,
            alignment: Alignment.centerRight,
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Manage projects",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white70,
                    ),
                  ),

                  Spacer(),

                  IconButton(
                    onPressed: () => showProfileDialog(context),
                    icon: Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.width * 0.14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
