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

  final Color _lightGrey = const Color(0xFFE5DFE6);
  final Color _pastelPurple = const Color(0xFFBA99EA);

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
                              color: isEarned ? _pastelPurple.withOpacity(0.2) : Colors.black.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              achievement.icon,
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
                                    achievement.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: isEarned ? Colors.black : Colors.black38,
                                    ),
                                  ),
                                  Text(
                                    achievement.description,
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
                                "x${achievement.count}",
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
  }
}
