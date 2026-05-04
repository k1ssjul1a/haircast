import 'package:flutter/material.dart';

class HairupdatesCard extends StatefulWidget {
  const HairupdatesCard({super.key});

  @override
  State<HairupdatesCard> createState() => _HairupdatesCardState();
}

class _HairupdatesCardState extends State<HairupdatesCard> {
  bool _washedToday = false;
  bool _newHaircut = false;
  bool _changedColor = false;
  final int _daysSinceWash = 2; // Dummy data

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
                  Icon(Icons.update, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Hair Updates",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              
              //Text(
              //  "Info: $_daysSinceWash day(s) since your last hairwash",
              //  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              //),
              //const SizedBox(height: 12),

              CheckboxListTile(
                title: const Text("I washed my hair today"),
                value: _washedToday,
                activeColor: Colors.teal[200],
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) {
                  setState(() {
                    _washedToday = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("I got a new haircut"),
                value: _newHaircut,
                activeColor: Colors.teal[200],
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) {
                  setState(() {
                    _newHaircut = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("I changed my hair color"),
                value: _changedColor,
                activeColor: Colors.teal[200],
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) {
                  setState(() {
                    _changedColor = value ?? false;
                  });
                },
              ),
              
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Additional notes",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Updates"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
