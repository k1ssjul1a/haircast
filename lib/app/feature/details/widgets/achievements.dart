import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final int count;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.count,
  });
}

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for the skeleton
    final List<Achievement> achievements = [
      Achievement(
        title: "Humidity Survivor",
        description: "Your hair stayed perfect despite high humidity!",
        icon: Icons.water_drop,
        count: 3,
      ),
      Achievement(
        title: "Wind Resistant Queen",
        description: "Managed a great hair day in breezy weather.",
        icon: Icons.air,
        count: 1,
      ),
      Achievement(
        title: "Rainy Day Legend",
        description: "Conquered the rain without the frizz.",
        icon: Icons.umbrella,
        count: 0,
      ),
      Achievement(
        title: "Sun Goddess",
        description: "Kept that glow under the scorching sun.",
        icon: Icons.wb_sunny,
        count: 0,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.emoji_events_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Achievements",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  final isEarned = achievement.count > 0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isEarned ? Colors.teal[50] : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            achievement.icon,
                            color: isEarned ? Colors.teal : Colors.grey,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievement.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: isEarned ? Colors.black87 : Colors.grey,
                                ),
                              ),
                              Text(
                                achievement.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isEarned ? Colors.black54 : Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isEarned)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "x${achievement.count}",
                              style: const TextStyle(
                                color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
