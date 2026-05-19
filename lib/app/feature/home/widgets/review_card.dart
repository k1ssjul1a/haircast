import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.onSave});

  final Future<void> Function(
      String? hairstyle,
      double rating,
      String? products,
      ) onSave;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  double _currentSliderValue = 5;
  String? _selectedHairstyle;
  final TextEditingController _productController = TextEditingController();

  final List<String> _hairstyles = [
    'Down',
    'Ponytail',
    'Bun',
    'Braids',
    'Other'
  ];

  final Color _lightGrey = const Color(0xFFE5DFE6);
  final Color _pastelPurple = const Color(0xFFBA99EA);

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    await widget.onSave(
      _selectedHairstyle,
      _currentSliderValue,
      _productController.text.isEmpty ? null : _productController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Card(
        color: _lightGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.rate_review_outlined,
                      color: Colors.black, size: 28),
                  SizedBox(width: 12),
                  Text(
                    "Hair Review",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hair Rating: ${_currentSliderValue.toInt()}/5",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    Slider(
                      value: _currentSliderValue,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: _pastelPurple,
                      inactiveColor: Colors.black12,
                      onChanged: (value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Hairstyle",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    DropdownButtonFormField<String>(
                      value: _selectedHairstyle,
                      decoration: InputDecoration(
                        hintText: "Select hairstyle (optional)",
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: _hairstyles.map((style) {
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
                  ],
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _productController,
                decoration: InputDecoration(
                  labelText: "Additional notes (optional)",
                  labelStyle: const TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Save Review",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
