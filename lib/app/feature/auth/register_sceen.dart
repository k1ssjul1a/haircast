import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/user_model.dart';
import '../../data/service/database_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controller, um den Text aus den Feldern zu lesen
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dbService = DatabaseService();

  void _saveUserData() async {
    // 1. Hole den aktuell angemeldeten User (von Firebase Auth)
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 2. Erstelle das Daten-Objekt
      final newUser = UserModel(
        id: user.uid, // Die eindeutige ID von Auth nutzen
        name: _nameController.text,
        email: user.email ?? _emailController.text,
        hairType: 'Normal', // Könnte man über ein Dropdown wählen
      );

      // 3. In Firestore speichern
      await _dbService.saveUser(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daten erfolgreich gespeichert!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil vervollständigen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}