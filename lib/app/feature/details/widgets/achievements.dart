import 'package:flutter/material.dart';

class Achievements extends StatelessWidget{
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title row
              Row(
                children: const [
                  //Icon(Icons.auto_awesome_rounded),
                  SizedBox(width: 8),
                  Text(
                    "Achievements:",
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
                  //Icon(Icons.water_drop_outlined, size: 18),
                  SizedBox(width: 8),
                  Text(""),
                ],
              ),
              const SizedBox(height: 8),
              // Context row 2
              const Row(
                children: [
                  //Icon(Icons.thermostat_outlined, size: 18),
                  SizedBox(width: 8),
                  Text(""),
                ],
              ),
              const SizedBox(height: 8),
              // Context row 3
              const Row(
                children: [
                  //Icon(Icons.air_outlined, size: 18),
                  SizedBox(width: 8),
                  Text(""),
                ],
              ),
              //const Divider(),
              const Row(
                  children: [
                    //Icon(Icons.assessment, size: 18),
                    SizedBox(width: 8),
                    Text ("")
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }

}