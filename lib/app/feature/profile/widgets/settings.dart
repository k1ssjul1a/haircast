import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  final Color _lightGrey = const Color(0xFFE5DFE6);

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
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.location_on_outlined,
                      label: "Location (City)",
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.email_outlined,
                      label: "Email or Phone Number",
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.face_2_rounded,
                      label: "Hair Type",
                      onTap: () {},
                    ),
                    _SettingsTile(
                      icon: Icons.calendar_month,
                      label: "Hairwash Cycle Days",
                      onTap: () {},
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
                  onPressed: () {},
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
      leading: Icon(icon, color: Colors.black, size: 20),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black26),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}
