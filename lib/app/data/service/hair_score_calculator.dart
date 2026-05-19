import '../user_model.dart';

class HairScoreResult {
  final int score;
  final List<String> negativeFactors;

  HairScoreResult({required this.score, required this.negativeFactors});

  String get scoreDisplay => "$score/5";
}

class HairScoreCalculator {
  static HairScoreResult calculateScore({
    required UserModel? user,
    required double? humidity,
    required double? rain,
    required double? wind,
  }) {
    if (user == null || 
        humidity == null || 
        rain == null ||
        wind == null) {
      return HairScoreResult(score: 0, negativeFactors: []);
    }

    int score = 5;
    List<String> negativeFactors = [];
    final String hairType = user.hairType.toLowerCase();
    final int cycle = user.hairwashCycle;
    
    bool isCurlyOrCoily = hairType.startsWith('3') || hairType.startsWith('4');

    // Hairwash cycle logic - skip if lastWashDate is missing
    if (user.lastWashDate != null) {
      final DateTime now = DateTime.now();
      final int daysSinceWash = now.difference(user.lastWashDate!).inDays;

      if (isCurlyOrCoily) {
        if (daysSinceWash >= cycle) {
          score -= 2;
          negativeFactors.add('cycle');
        } else if (daysSinceWash >= (cycle * 2 / 3)) {
          score -= 1;
          negativeFactors.add('cycle');
        }
      } else {
        // Default (Straight/Wavy/Normal)
        if (daysSinceWash >= cycle) {
          score -= 2;
          negativeFactors.add('cycle');
        } else if (daysSinceWash >= (cycle / 2)) {
          score -= 1;
          negativeFactors.add('cycle');
        }
      }
    }

    // Weather logic
    if (rain > 0) {
      score -= 1;
      negativeFactors.add('rain');
    }

    if (wind >= 20) {
      score -= 1;
      negativeFactors.add('wind');
    }

    if (isCurlyOrCoily) {
      if (humidity >= 75) {
        score -= 2;
        negativeFactors.add('humidity');
      } else if (humidity >= 55) {
        score -= 1;
        negativeFactors.add('humidity');
      }
    } else {
      // Default (Straight/Wavy/Normal)
      if (humidity >= 75) {
        score -= 1;
        negativeFactors.add('humidity');
      }
    }

    // Ensure score is within 1-5
    if (score < 1) score = 1;
    if (score > 5) score = 5;

    return HairScoreResult(score: score, negativeFactors: negativeFactors);
  }
}
