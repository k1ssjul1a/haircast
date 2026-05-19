import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/service/database_service.dart';
import '../../data/service/hair_score_calculator.dart';
import '../../data/user_model.dart';
import '../../../services/firestore_service.dart';
import 'widgets/haircast_card.dart';
import 'widgets/hairupdates_card.dart';
import 'widgets/review_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestoreService = FirestoreService();
  HairScoreResult? _currentPrediction;
  UserModel? _user;

  void _onPredictionChanged(HairScoreResult? result, UserModel? user) {
    setState(() {
      _currentPrediction = result;
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HAIRCAST",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 0, bottom: 120),
        child: Column(
          children: [
            HaircastCard(onPredictionFetched: _onPredictionChanged),
            ReviewCard(
              onSave: (hairstyle, rating, products) async {
                List<String>? achievements;
                
                if (_currentPrediction != null && _currentPrediction!.score <= 3 && rating >= 4) {
                  achievements = _currentPrediction!.negativeFactors;
                }

                await firestoreService.saveHairEntry(
                  hairstyle: hairstyle,
                  rating: rating.toInt(),
                  washDay: false,
                  products: products,
                  achievementsEarned: achievements,
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
