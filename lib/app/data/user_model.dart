import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String hairType; // e.g., '1a', '2b', '4c'
  final int hairwashCycle; // in days
  final DateTime? lastWashDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hairType = '',
    this.hairwashCycle = 3,
    this.lastWashDate,
  });

  // Wandelt ein Map (von Firestore) in ein Objekt um
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      hairType: data['hairType'] ?? '',
      hairwashCycle: data['hairwashCycle'] ?? 3,
      lastWashDate: data['lastWashDate'] != null 
          ? (data['lastWashDate'] as Timestamp).toDate() 
          : null,
    );
  }

  // Wandelt das Objekt in ein Map für Firestore um
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hairType': hairType,
      'hairwashCycle': hairwashCycle,
      'lastWashDate': lastWashDate != null ? Timestamp.fromDate(lastWashDate!) : null,
    };
  }
}

