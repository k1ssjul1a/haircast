import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    var snapshot = await _db.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data()!, snapshot.id);
    }
    return null;
  }
}
