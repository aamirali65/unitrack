import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
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
                      "https://i.ibb.co/4fShG3W/user.png", // temp image
                    ),
                  ),
                  const SizedBox(height: 14),

                  const CustomText(
                    text: "Ahmed Mughal",
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 6),

                  CustomText(
                    text: "BCS/BS 3 A - 2412133",
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- DETAILS CARD ----------
            _buildInfoCard(
              title: "Personal Information",
              items: [
                _infoTile("Full Name", "Ahmed mughal"),
                _infoTile("Email", "ahmed@example.com"),
                _infoTile("Phone", "+92 334 2144567"),
                _infoTile("Student ID", "2412133"),
                _infoTile("Program", "BS Computer Science"),
                _infoTile("Section", "BSCS-3A"),
                _infoTile("Batch", "Fall 2025"),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- LOGIN DETAILS ----------
            _buildInfoCard(
              title: "Account Details",
              items: [
                _infoTile("Username", "ahmed mughal"),
                _infoTile("Registered Email", "ahmed@example.com"),
                _infoTile("Password", "********"),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- ACADEMIC SUMMARY ----------
            _buildInfoCard(
              title: "Academic Summary",
              items: [
                _infoTile("Current Semester", "3rd Semester"),
                _infoTile("Total Credit Hours", "90"),
                _infoTile("CGPA", "3.25"),
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
