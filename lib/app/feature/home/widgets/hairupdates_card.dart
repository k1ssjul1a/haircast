import 'package:flutter/material.dart';
import '../../../../services/firestore_service.dart';

class HairupdatesCard extends StatefulWidget {
  const HairupdatesCard({super.key});

  @override
  State<HairupdatesCard> createState() => _HairupdatesCardState();
}

class _HairupdatesCardState extends State<HairupdatesCard> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _notesController = TextEditingController();

  bool _washedToday = false;
  bool _newHaircut = false;
  bool _changedColor = false;

  final Color _lightGrey = const Color(0xFFE5DFE6);

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveUpdates() async {
    try {
      await _firestoreService.updateHairUpdates(
        washedToday: _washedToday,
        newHaircut: _newHaircut,
        changedColor: _changedColor,
        notes: _notesController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Updates saved successfully!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving updates: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Card(
        color: _lightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.update, color: Colors.black, size: 28),
                  SizedBox(width: 12),
                  Text(
                    "Hair Updates",
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
                child: Column(
                  children: [
                    _buildCheckbox("I washed my hair today", _washedToday, (val) {
                      setState(() => _washedToday = val!);
                    }),
                    _buildCheckbox("I got a new haircut", _newHaircut, (val) {
                      setState(() => _newHaircut = val!);
                    }),
                    _buildCheckbox("I changed my hair color", _changedColor, (val) {
                      setState(() => _changedColor = val!);
                    }),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: "Additional notes",
                  labelStyle: const TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveUpdates,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text("Save Updates", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
      value: value,
      activeColor: Colors.black,
      checkColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      dense: true,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
