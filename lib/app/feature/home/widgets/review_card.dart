import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  double _currentSliderValue = 3;
  String? _selectedHairstyle;
  final List<String> _hairstyles = ['Down', 'Ponytail', 'Bun', 'Braids', 'Other'];

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
                  Icon(Icons.rate_review_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Today's Hair Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              
              // Score Rating
              Text("How do you rate your hair today? (${_currentSliderValue.toInt()}/5)",
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Slider(
                value: _currentSliderValue,
                max: 5,
                divisions: 4,
                label: _currentSliderValue.round().toString(),
                activeColor: Colors.teal[200],
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),

              // Hairstyle
              const Text("Hairstyle", style: TextStyle(fontWeight: FontWeight.w500)),
              DropdownButtonFormField<String>(
                initialValue: _selectedHairstyle,
                hint: const Text("Select hairstyle"),
                items: _hairstyles.map((String style) {
                  return DropdownMenuItem(
                    value: style,
                    child: Text(style),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedHairstyle = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Photo Upload Placeholder
              const Text("Photo", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: const Icon(Icons.add_a_photo_outlined, color: Colors.grey, size: 40),
              ),
              const SizedBox(height: 16),

              // Hair Products
              const TextField(
                decoration: InputDecoration(
                  labelText: "Hair products used",
                  hintText: "e.g., Shampoo, Conditioner, Oil",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Additional Notes
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Additional notes",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[200],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Review"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
