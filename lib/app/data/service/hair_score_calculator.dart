import '../user_model.dart';

class HairScoreCalculator {
  static String calculateScore({
    required UserModel? user,
    required double? humidity,
    required double? rain,
  }) {
    if (user == null || 
        humidity == null || 
        rain == null) {
      return "unknown";
    }

    int score = 5;
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
        } else if (daysSinceWash >= (cycle * 2 / 3)) {
          score -= 1;
        }
      } else {
        // Default (Straight/Wavy/Normal)
        if (daysSinceWash >= cycle) {
          score -= 2;
        } else if (daysSinceWash >= (cycle / 2)) {
          score -= 1;
        }
      }
    }

    // Weather logic
    if (rain > 0) {
      score -= 1;
    }

    if (isCurlyOrCoily) {
      if (humidity >= 75) {
        score -= 2;
      } else if (humidity >= 55) {
        score -= 1;
      }
    } else {
      // Default (Straight/Wavy/Normal)
      if (humidity >= 75) {
        score -= 1;
      }
    }

    // Ensure score is within 1-5
    if (score < 1) score = 1;
    if (score > 5) score = 5;

    return "$score/5";
  }
}
