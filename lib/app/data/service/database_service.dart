import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Benutzerdaten speichern oder aktualisieren
  Future<void> saveUser(UserModel user) async {
    // Use merge: true to avoid overwriting fields that might be updated by other services (like achievements)
    await _db.collection('users').doc(user.id).set(user.toMap(), SetOptions(merge: true));
  }

  // Benutzerdaten abrufen
  Future<UserModel?> getUser(String uid) async {
    var snapshot = await _db.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data()!, snapshot.id);
    }
    return null;
  }

  // Stream für Echtzeit-Updates
  Stream<UserModel?> watchUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
}
