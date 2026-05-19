import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/service/database_service.dart';
import '../../../data/user_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Color _lightGrey = const Color(0xFFE5DFE6);
  final DatabaseService _dbService = DatabaseService();
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  final List<String> _hairTypes = [
    '1a', '1b', '1c', '1d',
    '2a', '2b', '2c', '2d',
    '3a', '3b', '3c', '3d',
    '4a', '4b', '4c', '4d'
  ];

  void _showNameDialog(UserModel user) {
    final controller = TextEditingController(text: user.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              final updatedUser = user.copyWith(name: controller.text);
              await _dbService.saveUser(updatedUser);
              if (mounted) setState(() {});
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog(UserModel user) {
    final controller = TextEditingController(text: user.location);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Location"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter city"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              final updatedUser = user.copyWith(location: controller.text);
              await _dbService.saveUser(updatedUser);
              if (mounted) setState(() {});
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showHairTypeDialog(UserModel user) {
    String selectedType = _hairTypes.contains(user.hairType) ? user.hairType : _hairTypes.first;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Change Hair Type"),
          content: DropdownButton<String>(
            value: selectedType,
            isExpanded: true,
            items: _hairTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            onChanged: (value) {
              if (value != null) setDialogState(() => selectedType = value);
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () async {
                final updatedUser = user.copyWith(hairType: selectedType);
                await _dbService.saveUser(updatedUser);
                if (mounted) setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _showWashCycleDialog(UserModel user) {
    int selectedCycle = user.hairwashCycle;
    DateTime? selectedDate = user.lastWashDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Change Hairwash Cycle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Days between washes:", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<int>(
                value: selectedCycle,
                isExpanded: true,
                items: List.generate(14, (index) => index + 1)
                    .map((val) => DropdownMenuItem(value: val, child: Text("$val Days")))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => selectedCycle = value);
                },
              ),
              const SizedBox(height: 20),
              const Text("Last wash date:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setDialogState(() => selectedDate = pickedDate);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate == null
                            ? "Select Date"
                            : "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}",
                      ),
                      const Icon(Icons.calendar_today, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () async {
                final updatedUser = user.copyWith(
                  hairwashCycle: selectedCycle,
                  lastWashDate: selectedDate,
                );
                await _dbService.saveUser(updatedUser);
                if (mounted) setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) return const Center(child: Text("Please log in"));

    return FutureBuilder<UserModel?>(
      future: _dbService.getUser(_uid),
      builder: (context, snapshot) {
        final user = snapshot.data;
        String washSubtitle = "";
        if (user != null) {
          washSubtitle = "${user.hairwashCycle} Days";
          if (user.lastWashDate != null) {
            washSubtitle += " • Last: ${_formatDate(user.lastWashDate)}";
          }
        }

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
                      Icon(Icons.settings_outlined, color: Colors.black, size: 28),
                      SizedBox(width: 12),
                      Text(
                        "Settings",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.person_outline,
                          label: "Change Name",
                          subtitle: user?.name,
                          onTap: () => user != null ? _showNameDialog(user) : null,
                        ),
                        _SettingsTile(
                          icon: Icons.location_on_outlined,
                          label: "Location (City)",
                          subtitle: user?.location,
                          onTap: () => user != null ? _showLocationDialog(user) : null,
                        ),
                        _SettingsTile(
                          icon: Icons.email_outlined,
                          label: "Email or Phone Number",
                          subtitle: user?.email,
                          onTap: () {},
                        ),
                        _SettingsTile(
                          icon: Icons.face_2_rounded,
                          label: "Hair Type",
                          subtitle: user?.hairType,
                          onTap: () => user != null ? _showHairTypeDialog(user) : null,
                        ),
                        _SettingsTile(
                          icon: Icons.calendar_month,
                          label: "Hairwash Info",
                          subtitle: washSubtitle,
                          onTap: () => user != null ? _showWashCycleDialog(user) : null,
                        ),
                        _SettingsTile(
                          icon: Icons.lock_outline,
                          label: "Change Password",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 8),
                    child: Text(
                      "Support & Info",
                      style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        _SettingsTile(
                          icon: Icons.help_outline,
                          label: "How it works",
                          onTap: () {},
                        ),
                        _SettingsTile(
                          icon: Icons.lightbulb_outline,
                          label: "Tips & Tricks",
                          onTap: () {},
                        ),
                        _SettingsTile(
                          icon: Icons.group_outlined,
                          label: "About Our Team",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
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

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 20),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      subtitle: (subtitle != null && subtitle!.isNotEmpty)
          ? Text(subtitle!, style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.black26),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
