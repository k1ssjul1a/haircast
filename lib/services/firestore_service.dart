import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No logged in user found");
    }
    return user.uid;
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> saveHairEntry({
    required String hairstyle,
    required int rating,
    required bool washDay,
    required String products,
  }) async {
    final today = DateTime.now();
    final docId = _formatDate(today);

    await _db
        .collection('users')
        .doc(_uid)
        .collection('hairEntries')
        .doc(docId)
        .set({
      'date': Timestamp.fromDate(today),
      'hairstyle': hairstyle,
      'rating': rating,
      'washDay': washDay,
      'products': products,
    });
  }

  Future<Map<String, dynamic>?> getHairEntryByDate(DateTime date) async {
    final docId = _formatDate(date);

    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('hairEntries')
        .doc(docId)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }
}

//