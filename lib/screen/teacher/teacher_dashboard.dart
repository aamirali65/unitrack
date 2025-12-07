import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../utils/theme_colors.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: ThemeColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const CustomText(
          textAlign: TextAlign.center,
          fontSize: 20,
          text: "UniTrack Teacher Portal",
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        leading: GestureDetector(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, size: 28),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Curved background header
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.23,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: ThemeColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome, Sir Ahmed",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ahmed@university.edu.pk",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      "Teacher ID: T-45678",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Grid cards for teacher features
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                  children: const [
                    DashboardCard(
                      title: "Attendance",
                      icon: Icons.fact_check_outlined,
                      color: Colors.blue,
                    ),
                    DashboardCard(
                      title: "Class Schedule",
                      icon: Icons.calendar_month_outlined,
                      color: Colors.green,
                    ),
                    DashboardCard(
                      title: "Upload Marks",
                      icon: Icons.upload_file_outlined,
                      color: Colors.orange,
                    ),
                    DashboardCard(
                      title: "Student List",
                      icon: Icons.people_outline,
                      color: Colors.purple,
                    ),
                    DashboardCard(
                      title: "Assignments",
                      icon: Icons.assignment_outlined,
                      color: Colors.teal,
                    ),
                    DashboardCard(
                      title: "Notices",
                      icon: Icons.notifications_active_outlined,
                      color: Colors.red,
                    ),
                    DashboardCard(
                      title: "Profile",
                      icon: Icons.person_outline,
                      color: Colors.indigo,
                    ),
                    DashboardCard(
                      title: "Messages",
                      icon: Icons.message_outlined,
                      color: Colors.brown,
                    ),
                    DashboardCard(
                      title: "Settings",
                      icon: Icons.settings_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Card widget
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Same clipper you already used
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 50);
    p.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
