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
    String? hairstyle,
    required int rating,
    required bool washDay,
    String? products,
    List<String>? achievementsEarned,
  }) async {
    final today = DateTime.now();
    final docId = _formatDate(today);

    final batch = _db.batch();
    
    final entryRef = _db
        .collection('users')
        .doc(_uid)
        .collection('hairEntries')
        .doc(docId);
    
    batch.set(entryRef, {
      'date': Timestamp.fromDate(today),
      'hairstyle': hairstyle,
      'rating': rating,
      'washDay': washDay,
      'products': products,
    });

    if (achievementsEarned != null && achievementsEarned.isNotEmpty) {
      final userRef = _db.collection('users').doc(_uid);
      final updates = <String, dynamic>{};
      for (final achievement in achievementsEarned) {
        updates['achievements.$achievement'] = FieldValue.increment(1);
      }
      batch.update(userRef, updates);
    }

    await batch.commit();
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

  Stream<Map<String, int>> achievementsStream() {
    return _db.collection('users').doc(_uid).snapshots().map((doc) {
      final data = doc.data();
      if (data == null || data['achievements'] == null) return {};
      final Map<String, dynamic> achievements = data['achievements'];
      return achievements.map((key, value) => MapEntry(key, value as int));
    });
  }
}
