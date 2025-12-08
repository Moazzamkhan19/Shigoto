import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shigoto/Model/Project_Model.dart';

class Projectcontroller {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //-------------------ADD-PROJECT-------------------------------//
  Future<String> addProject({
    required String projectTitle,
    required String description,
    required DateTime startdate,
    required DateTime enddate,
    required String ownerid,
    required String status,
  }) async {
    try {
      final docRef = _firestore.collection("projects").doc();
      final String autoId = docRef.id;

      ProjectModel project = ProjectModel(
        projectId: autoId,
        ownerId: ownerid,
        projectTitle: projectTitle,
        description: description,
        startDate: startdate,
        endDate: enddate,
        status: status,
      );

      await docRef.set(project.toMap());
      print("Firestore write SUCCESS");

      return autoId;

    } on FirebaseException catch (e) {
      print("FIREBASE ERROR: ${e.message}");
      return e.message ?? "FAILED TO SAVE";
    } catch (e) {
      print("Generic error: $e");
      return e.toString();
    }
  }
  //-------------------REMOVE PROJECT-----------------------//
  Future<String> deleteProject({
    required String userid,
    required String projectid,
  }) async {
    try {
      // DELETE FROM THE SAME COLLECTION YOU READ FROM
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectid)
          .delete();

      return "Project deleted";
    } catch (e) {
      return "Error detected : $e";
    }
  }

  //-------------------UPDATE PROJECT----------------------//
  Future<String> updateProject({
    required String projectId,
    String? projectTitle,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    try {
      Map<String, dynamic> updateData = {};

      if (projectTitle != null) updateData['projectTitle'] = projectTitle;
      if (description != null) updateData['description'] = description;
      if (startDate != null) updateData['startDate'] = startDate;
      if (endDate != null) updateData['endDate'] = endDate;
      if (status != null) updateData['status'] = status;

      if (updateData.isEmpty) {
        return "Nothing to update";
      }

      await FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .update(updateData);

      return "Project updated successfully";
    } catch (e) {
      return "Update error: $e";
    }
  }



}