import 'package:cloud_firestore/cloud_firestore.dart';
class AnnouncementModel {
  final String announcementId;
  final String projectId;
  final String userId; // who posted the announcement
  final String message;
  final DateTime createdAt;

  AnnouncementModel({
    required this.announcementId,
    required this.projectId,
    required this.userId,
    required this.message,
    required this.createdAt,
  });

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      announcementId: map['announcementId'],
      projectId: map['projectId'],
      userId: map['userId'],
      message: map['message'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'announcementId': announcementId,
      'projectId': projectId,
      'userId': userId,
      'message': message,
      'createdAt': createdAt,
    };
  }
}
