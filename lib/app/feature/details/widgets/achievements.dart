import 'package:flutter/material.dart';
import '../../../../services/firestore_service.dart';

class AchievementData {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  AchievementData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  final Color _lightGrey = const Color(0xFFE5DFE6);
  final Color _pastelPurple = const Color(0xFFBA99EA);

  static final List<AchievementData> _achievementTypes = [
    AchievementData(
      id: "humidity",
      title: "Humidity Survivor",
      description: "Your hair stayed perfect despite high humidity!",
      icon: Icons.water_drop,
    ),
    AchievementData(
      id: "rain",
      title: "Rainy Day Legend",
      description: "Conquered the rain without the frizz.",
      icon: Icons.umbrella,
    ),
    AchievementData(
      id: "wind",
      title: "Wind Warrior",
      description: "Kept your hairstyle intact through the breeze!",
      icon: Icons.air,
    ),
    AchievementData(
      id: "cycle",
      title: "Wash Day Warrior",
      description: "Managed a great hair day late in your wash cycle.",
      icon: Icons.refresh,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return StreamBuilder<Map<String, int>>(
      stream: firestoreService.achievementsStream(),
      builder: (context, snapshot) {
        final earnedData = snapshot.data ?? {};
        int totalAchievements = earnedData.values.fold(0, (sum, count) => sum + count);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Card(
            color: _lightGrey,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events_outlined, color: Colors.black, size: 28),
                      SizedBox(width: 12),
                      Text(
                        "Achievements",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Total number of your achievements: $totalAchievements",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _achievementTypes.length,
                      itemBuilder: (context, index) {
                        final type = _achievementTypes[index];
                        final count = earnedData[type.id] ?? 0;
                        final isEarned = count > 0;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isEarned ? _pastelPurple.withOpacity(0.2) : Colors.black.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  type.icon,
                                  color: isEarned ? Colors.black : Colors.black26,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        type.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: isEarned ? Colors.black : Colors.black38,
                                        ),
                                      ),
                                      Text(
                                        type.description,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isEarned ? Colors.black54 : Colors.black26,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (isEarned)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _pastelPurple,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "x$count",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
