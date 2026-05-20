import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String hairType; // e.g., '1a', '2b', '4c'
  final int hairwashCycle; // in days
  final DateTime? lastWashDate;
  final String location;
  final Map<String, int> achievements;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hairType = '',
    this.hairwashCycle = 3,
    this.lastWashDate,
    this.location = '',
    this.achievements = const {},
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    Map<String, int> achievementsMap = {};
    if (data['achievements'] != null && data['achievements'] is Map) {
      final Map<dynamic, dynamic> rawAchievements = data['achievements'];
      achievementsMap = rawAchievements.map(
        (key, value) => MapEntry(key.toString(), (value as num).toInt()),
      );
    }

    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      hairType: data['hairType'] ?? '',
      hairwashCycle: data['hairwashCycle'] ?? 3,
      lastWashDate: data['lastWashDate'] != null
          ? (data['lastWashDate'] as Timestamp).toDate()
          : null,
      location: data['location'] ?? '',
      achievements: achievementsMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hairType': hairType,
      'hairwashCycle': hairwashCycle,
      'lastWashDate': lastWashDate != null ? Timestamp.fromDate(lastWashDate!) : null,
      'location': location,
      'achievements': achievements,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? hairType,
    int? hairwashCycle,
    DateTime? lastWashDate,
    String? location,
    Map<String, int>? achievements,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      hairType: hairType ?? this.hairType,
      hairwashCycle: hairwashCycle ?? this.hairwashCycle,
      lastWashDate: lastWashDate ?? this.lastWashDate,
      location: location ?? this.location,
      achievements: achievements ?? this.achievements,
    );
  }
}
