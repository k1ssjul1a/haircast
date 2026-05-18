class UserModel {
  final String id;
  final String name;
  final String email;
  final String hairType;
  final int hairwashCycle;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hairType = '',
    this.hairwashCycle = 1,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      hairType: data['hairType'] ?? '',
      hairwashCycle: data['hairwashCycle'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hairType': hairType,
      'hairwashCycle': hairwashCycle,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? hairType,
    int? hairwashCycle,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      hairType: hairType ?? this.hairType,
      hairwashCycle: hairwashCycle ?? this.hairwashCycle,
    );
  }
}
