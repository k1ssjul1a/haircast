import 'package:flutter/material.dart';

import 'widgets/achievements.dart';
import 'widgets/calendar.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Hello [user]")
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            Calendar(),
            Achievements()
            //CalendarOverview(),
          ],
        ),
      ),
    );
  }
}
