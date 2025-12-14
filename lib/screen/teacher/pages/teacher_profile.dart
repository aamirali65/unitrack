import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const CustomText(
          text: "Profile",
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ---------- PROFILE HEADER ----------
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      "https://i.ibb.co/4fShG3W/user.png", // you can replace with teacher pic
                    ),
                  ),
                  const SizedBox(height: 14),

                  const CustomText(
                    text: "Dr. Aamir Ali",
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 6),

                  CustomText(
                    text: "Computer Science Department",
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- PERSONAL INFO ----------
            _buildInfoCard(
              title: "Personal Information",
              items: [
                _infoTile("Full Name", "Dr. Aamir Ali"),
                _infoTile("Email", "aamir.teacher@example.com"),
                _infoTile("Phone", "+92 300 1234567"),
                _infoTile("Employee ID", "T-2412170"),
                _infoTile("Department", "Computer Science"),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- ACCOUNT DETAILS ----------
            _buildInfoCard(
              title: "Account Details",
              items: [
                _infoTile("Username", "aamir_teacher"),
                _infoTile("Registered Email", "aamir.teacher@example.com"),
                _infoTile("Password", "********"),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- PROFESSIONAL SUMMARY ----------
            _buildInfoCard(
              title: "Professional Summary",
              items: [
                _infoTile("Designation", "Assistant Professor"),
                _infoTile("Experience", "5 years"),
                _infoTile("Courses Handling", "Data Structures, Algorithms, Operating Systems"),
                _infoTile("Status", "Active"),
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ----------- CARD WIDGET -------------
  Widget _buildInfoCard({required String title, required List<Widget> items}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: ThemeColors.primary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: ThemeColors.primary,
            ),
            const SizedBox(height: 12),
            ...items,
          ],
        ),
      ),
    );
  }

  // ----------- ROW ITEM -------------
  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              text: label,
              fontWeight: FontWeight.w600,
              color: ThemeColors.primary,
              fontSize: 15,
            ),
          ),
          Expanded(
            flex: 4,
            child: CustomText(
              text: value,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
