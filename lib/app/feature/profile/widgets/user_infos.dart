import 'package:flutter/material.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({super.key});

  final Color _pastelPurple = const Color(0xFFBA99EA);

  @override
  Widget build(BuildContext context) {
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
              const Text(
                "User Example",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                "Curly Hair (Type 3A)",
                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    "Berlin, Germany",
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
                child: const IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoStat(label: "Wash Cycle", value: "4 Days"),
                      VerticalDivider(thickness: 1, color: Colors.black12),
                      _InfoStat(label: "Next Wash", value: "In 2 Days"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
