import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/service/database_service.dart';
import '../../../data/user_model.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({super.key});

  final Color _pastelPurple = const Color(0xFFBA99EA);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text("Not logged in"));
    }

    return StreamBuilder<UserModel?>(
      stream: DatabaseService().watchUser(currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator(color: Colors.black)),
          );
        }

        final userData = snapshot.data;
        final name = userData?.name ?? (currentUser.isAnonymous ? "Guest User" : "User Example");
        final hairType = userData?.hairType != null && userData!.hairType.isNotEmpty ? userData.hairType : "No hair type set";
        final location = userData?.location;

        String nextWashDisplay = "?";
        if (userData?.lastWashDate != null) {
          final nextWashDate = userData!.lastWashDate!.add(Duration(days: userData.hairwashCycle));
          final today = DateTime.now();
          final remaining = nextWashDate.difference(DateTime(today.year, today.month, today.day)).inDays;
          nextWashDisplay = "$remaining Days";
        }

        final totalAchievements = userData?.achievements.values.fold(0, (sum, count) => sum + count) ?? 0;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Card(
            color: _pastelPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person_pin_rounded, color: Colors.black, size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        "Profile",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Hair Type: $hairType",
                    style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(
                        location ?? "No location set",
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _InfoStat(label: "Wash Cycle", value: "${userData?.hairwashCycle ?? 1} Days"),
                          const VerticalDivider(thickness: 1, color: Colors.black12),
                          _InfoStat(label: "Next Wash", value: nextWashDisplay),
                          const VerticalDivider(thickness: 1, color: Colors.black12),
                          _InfoStat(label: "Achievements", value: "$totalAchievements"),
                        ],
                      ),
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

class _InfoStat extends StatelessWidget {
  final String label;
  final String value;

  const _InfoStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
