import 'package:flutter/material.dart';

class HaircastCard extends StatelessWidget {
  const HaircastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Colors.teal[200],
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //test
            children: <Widget>[
              // Title row
              Row(
                children: const [
                  Icon(Icons.auto_awesome_rounded),
                  SizedBox(width: 8),
                  Text(
                    "Today's Haircast:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(),
              // Context row 1
              const Row(
                children: [
                  Icon(Icons.water_drop_outlined, size: 18),
                  SizedBox(width: 8),
                  Text("Factor 1"),
                ],
              ),
              const SizedBox(height: 8),
              // Context row 2
              const Row(
                children: [
                  Icon(Icons.thermostat_outlined, size: 18),
                  SizedBox(width: 8),
                  Text("Factor 2"),
                ],
              ),
              const SizedBox(height: 8),
              // Context row 3
              const Row(
                children: [
                  Icon(Icons.air_outlined, size: 18),
                  SizedBox(width: 8),
                  Text("Factor 3"),
                ],
              ),
              const Divider(),
              const Row(
                  children: [
                    Icon(Icons.assessment, size: 18),
                    SizedBox(width: 8),
                    Text ("Hair score prediction: [score]")
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}