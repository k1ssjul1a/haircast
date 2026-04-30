class UserModel {
  final String id;
  final String name;
  final String email;
  final String hairType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.hairType = 'Normal',
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      hairType: data['hairType'] ?? 'Normal',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hairType': hairType,
    };
  }
}
