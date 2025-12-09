import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Task_Model.dart';

class TaskController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String tasksCollection = 'tasks';

  Future<bool> addTask({
    required String projectId,
    required String taskName,
    required String description,
    required String status,
    required int priority,
    required String ownerId,
    required List<String> assignedTo,
    DateTime? dueDate,
  }) async {
    try {
      final taskDoc = _firestore.collection(tasksCollection).doc();
      final taskId = taskDoc.id;

      final task = TaskModel(
        taskId: taskId,
        projectId: projectId,
        taskName: taskName,
        status: status,
        description: description,
        dueDate: dueDate ?? DateTime.now().add(Duration(days: 7)),
        priority: priority,
        ownerId: ownerId,
        assignedTo: assignedTo,
      );

      await taskDoc.set(task.toMap());
      return true;
    } catch (e) {
      print('Error adding task: $e');
      return false;
    }
  }

  Stream<List<TaskModel>>? getProjectTasks(String projectId) {
    return FirebaseFirestore.instance
        .collection('tasks')
        .where('projectId', isEqualTo: projectId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .toList());
  }


}
