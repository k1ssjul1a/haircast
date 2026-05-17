import 'package:flutter/material.dart';

import 'widgets/haircast_card.dart';
import 'widgets/hairupdates_card.dart';
import 'widgets/review_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Hello [user]")
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 120), // Added padding to prevent navbar covering content
        child: Column(
          children: [
            HaircastCard(),
            ReviewCard(),
            HairupdatesCard(),
          ],
        ),
      ),
    );
  }
}
