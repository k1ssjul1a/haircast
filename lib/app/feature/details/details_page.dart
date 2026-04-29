import 'package:flutter/material.dart';

import 'widgets/achievements.dart';
import 'widgets/calendar_overview.dart';

class DetailsPage extends StatelessWidget{
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Hello [user]")
      ),
      body: const Column(
        children: [
          Achievements(),
          CalendarOverview(),
        ],
      ),
    );
    throw UnimplementedError();
  }
}