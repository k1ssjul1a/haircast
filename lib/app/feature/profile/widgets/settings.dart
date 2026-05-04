import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                  Icon(Icons.settings_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(),
              _SettingsTile(
                icon: Icons.person_outline,
                label: "Change Name",
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.email_outlined,
                label: "Email or Phone Number",
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.face_2_rounded, // Using a generic icon if hairdressing isn't available
                label: "Hair Type",
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.calendar_month, // Placeholder for wash cycle
                label: "Hairwash Cycle Days",
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.lock_outline,
                label: "Change Password",
                onTap: () {},
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Support & Info",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
              _SettingsTile(
                icon: Icons.help_outline,
                label: "Help Section",
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                  ),
                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
