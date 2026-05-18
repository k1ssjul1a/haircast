import '../user_model.dart';

class HairScoreCalculator {
  static String calculateScore({
    required UserModel? user,
    required double? humidity,
    required double? rain,
  }) {
    if (user == null || 
        user.hairType.isEmpty || 
        user.lastWashDate == null || 
        humidity == null || 
        rain == null) {
      return "unknown";
    }

    int score = 5;
    final String hairType = user.hairType.toLowerCase();
    final int cycle = user.hairwashCycle;
    final DateTime now = DateTime.now();
    final int daysSinceWash = now.difference(user.lastWashDate!).inDays;

    bool isStraightOrWavy = hairType.startsWith('1') || hairType.startsWith('2');
    bool isCurlyOrCoily = hairType.startsWith('3') || hairType.startsWith('4');

    if (isStraightOrWavy) {
      // Hairwash cycle logic
      if (daysSinceWash >= cycle) {
        score -= 2;
      } else if (daysSinceWash >= (cycle / 2)) {
        score -= 1;
      }

      // Weather logic
      if (rain > 0) {
        score -= 1;
      }
      if (humidity >= 80) {
        score -= 1;
      }
    } else if (isCurlyOrCoily) {
      // Hairwash cycle logic
      if (daysSinceWash >= cycle) {
        score -= 2;
      } else if (daysSinceWash >= (cycle * 2 / 3)) {
        score -= 1;
      }

      // Weather logic
      if (rain > 0) {
        score -= 1;
      }
      if (humidity >= 80) {
        score -= 2;
      } else if (humidity >= 60) {
        score -= 1;
      }
    } else {
      return "unknown";
    }

    // Ensure score is within 1-5
    if (score < 1) score = 1;
    if (score > 5) score = 5;

    return "$score/5";
  }
}

//