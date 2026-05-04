import 'package:flutter/material.dart';

class HaircastCard extends StatelessWidget {
  const HaircastCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.auto_awesome_rounded, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Today's Haircast",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // Weather Factors
              const Text(
                "Weather Factors:",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 8),
              const _FactorRow(icon: Icons.water_drop_outlined, label: "Humidity", value: "High"),
              const _FactorRow(icon: Icons.air_outlined, label: "Wind", value: "Breezy"),
              const _FactorRow(icon: Icons.umbrella_outlined, label: "Rain", value: "None"),
              const _FactorRow(icon: Icons.wb_sunny_outlined, label: "Sun", value: "Sunny"),
              
              const SizedBox(height: 12),
              
              // Hair Factors
              const Text(
                "Hair Factors:",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 8),
              const _FactorRow(icon: Icons.calendar_today_outlined, label: "Days since wash", value: "2 days"),

              const Divider(),
              const SizedBox(height: 8),
              
              // Predicted Hair Score
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Predicted Hair Score:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "8/10",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.teal[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              
              // Funny/Sweet Note
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal[100]!),
                ),
                child: const Text(
                  "\"Your hair looks so good today, even the wind is jealous!\"",
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FactorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _FactorRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
