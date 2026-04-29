import 'package:flutter/material.dart';

import 'widgets/haircast_card.dart';
import 'widgets/hairupdates_card.dart';
import 'widgets/review_card.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Hello [user]")
      ),
      body: const Column(
        children: [
          HaircastCard(),
          ReviewCard(),
          HairupdatesCard(),
        ],
      ),
    );
    throw UnimplementedError();
  }
}