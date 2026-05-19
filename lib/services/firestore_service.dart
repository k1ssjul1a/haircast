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
    final d = DateTime(date.year, date.month, date.day);
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  Future<void> saveHairEntry({
    String? hairstyle,
    required int rating,
    bool? washDay,
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
    
    final Map<String, dynamic> data = {
      'date': Timestamp.fromDate(today),
      'hairstyle': hairstyle,
      'rating': rating,
      'products': products,
    };
    
    if (washDay != null) {
      data['washDay'] = washDay;
    }

    batch.set(entryRef, data, SetOptions(merge: true));

    if (achievementsEarned != null && achievementsEarned.isNotEmpty) {
      final userRef = _db.collection('users').doc(_uid);
      final updates = <String, dynamic>{};
      for (final achievement in achievementsEarned) {
        updates['achievements.$achievement'] = FieldValue.increment(1);
      }
      batch.update(userRef, updates);
    }

    if (washDay == true) {
      final userRef = _db.collection('users').doc(_uid);
      batch.update(userRef, {'lastWashDate': Timestamp.fromDate(today)});
    }

    await batch.commit();
  }

  Future<void> updateHairUpdates({
    required bool washedToday,
    required bool newHaircut,
    required bool changedColor,
    String? notes,
  }) async {
    final today = DateTime.now();
    final docId = _formatDate(today);
    final userRef = _db.collection('users').doc(_uid);
    final entryRef = userRef.collection('hairEntries').doc(docId);

    final batch = _db.batch();

    batch.set(entryRef, {
      'date': Timestamp.fromDate(today),
      'washDay': washedToday,
      'newHaircut': newHaircut,
      'changedColor': changedColor,
      'notes': notes,
    }, SetOptions(merge: true));

    if (washedToday) {
      batch.update(userRef, {
        'lastWashDate': Timestamp.fromDate(today),
      });
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
