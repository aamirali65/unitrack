import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentSettingsPage extends StatefulWidget {
  const StudentSettingsPage({super.key});

  @override
  State<StudentSettingsPage> createState() => _StudentSettingsPageState();
}

class _StudentSettingsPageState extends State<StudentSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Header
          Text(
            "General",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),

          _settingTile(
            icon: Icons.person,
            title: "Profile Information",
            subtitle: "View and update your personal details",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          _settingTile(
            icon: Icons.lock,
            title: "Change Password",
            subtitle: "Update your login credentials",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          _settingTile(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Manage exam and portal alerts",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          const SizedBox(height: 20),

          // App settings
          Text(
            "App Preferences",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),

          _settingTile(
            icon: Icons.color_lens,
            title: "Theme",
            subtitle: "Light or dark appearance",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          _settingTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "English (Default)",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          const SizedBox(height: 20),

          // Security & Privacy
          Text(
            "Security",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),

          _settingTile(
            icon: Icons.shield,
            title: "Privacy Policy",
            subtitle: "Read how your data is handled",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          _settingTile(
            icon: Icons.description,
            title: "Terms & Conditions",
            subtitle: "University portal usage rules",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          const SizedBox(height: 20),

          // Help section
          Text(
            "Help & Support",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),

          _settingTile(
            icon: Icons.help_center,
            title: "FAQ",
            subtitle: "Common questions",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),
          _settingTile(
            icon: Icons.support_agent,
            title: "Contact Support",
            subtitle: "Reach out to admin or IT support",
            color: primary,
            onTap: ()=> Navigator.pushNamed(context, '/'),
          ),

          const SizedBox(height: 30),
          _settingTile(
            icon: Icons.logout,
            title: "Logout",
            subtitle: "Logout from the app",
            color: primary,
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              context.go('/login'); // clear navigation stack and go to login
            },

          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Reusable tile widget
  Widget _settingTile({
    required VoidCallback onTap,
    required IconData icon,
    required String title,
    required String subtitle,

    required Color color,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
