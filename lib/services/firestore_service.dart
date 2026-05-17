import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> saveHairEntry({
    required String hairstyle,
    required int rating,
    required bool washDay,
  }) async {

    final today = DateTime.now();
    final docId = "${today.year}-${today.month}-${today.day}";

    await _db
        .collection('users')
        .doc(_uid)
        .collection('hairEntries')
        .doc(docId)
        .set({
      'date': today,
      'hairstyle': hairstyle,
      'rating': rating,
      'washDay': washDay,
    });
  }
}