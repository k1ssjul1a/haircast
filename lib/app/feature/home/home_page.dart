import 'package:flutter/material.dart';

import '../../../services/firestore_service.dart';
import 'widgets/haircast_card.dart';
import 'widgets/hairupdates_card.dart';
import 'widgets/review_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        // title: const Text("Hello [user]")
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            const HaircastCard(),

            ReviewCard(
              onSave: (hairstyle, rating, products) async {
                await firestoreService.saveHairEntry(
                  hairstyle: hairstyle,
                  rating: rating.toInt(),
                  washDay: false,
                );
              },
            ),

            const HairupdatesCard(),
          ],
        ),
      ),
    );
  }
}