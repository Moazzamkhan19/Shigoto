import 'package:cloud_firestore/cloud_firestore.dart';
class TaskModel {
  final String taskId;
  final String projectId;
  final String taskName;
  final String status; // pending, in_progress, completed, not_started
  final List<String> assignedTo; // userIds from FirebaseAuth
  final String description;
  final List<String> comments; // can expand later
  final DateTime dueDate;
  final int priority; // 0 = low, 1 = medium, 2 = high

  TaskModel({
    required this.taskId,
    required this.projectId,
    required this.taskName,
    required this.status,
    required this.assignedTo,
    required this.description,
    required this.comments,
    required this.dueDate,
    required this.priority,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'],
      projectId: map['projectId'],
      taskName: map['taskName'],
      status: map['status'],
      assignedTo: List<String>.from(map['assignedTo'] ?? []),
      description: map['description'],
      comments: List<String>.from(map['comments'] ?? []),
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      priority: map['priority'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'projectId': projectId,
      'taskName': taskName,
      'status': status,
      'assignedTo': assignedTo,
      'description': description,
      'comments': comments,
      'dueDate': dueDate,
      'priority': priority,
    };
  }
}
