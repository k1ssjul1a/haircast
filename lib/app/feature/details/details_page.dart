import 'package:flutter/material.dart';

import 'widgets/achievements.dart';
import 'widgets/calendar.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DETAILS",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 0, bottom: 120),
        child: Column(
          children: [
            Calendar(),
            Achievements(),
          ],
        ),
      ),
    );
  }
}
