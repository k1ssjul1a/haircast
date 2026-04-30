class UserModel {
  final String id;
  final String name;
  final String email;
  final String hairType; // Beispiel für deine App

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hairType = '',
  });

  // Wandelt ein Map (von Firestore) in ein Objekt um
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      hairType: data['hairType'] ?? '',
    );
  }

  // Wandelt das Objekt in ein Map für Firestore um
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hairType': hairType,
    };
  }
}