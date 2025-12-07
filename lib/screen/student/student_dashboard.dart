import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../utils/theme_colors.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
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
          fontSize: 20, text:   "UniTrack University Portal",
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
                height: MediaQuery.of(context).size.height * 0.30,   // 32 percent of screen height
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: ThemeColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome, Aamir",
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "aamir@gmail.com",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      "Student ID: 2025-12345",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 3,                // 3 cards per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,           // controls height of card
                    children: [
                      DashboardCard(
                        title: "Today Lecture",
                        icon: Icons.play_lesson_outlined,
                        color: Colors.blue,
                        onTap: () => context.push("/student/today-lecture"),
                      ),
                      DashboardCard(
                        title: "Attendance",
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                        onTap: () => context.push("/student/attendance"),
                      ),
                      DashboardCard(
                        title: "Syllabus",
                        icon: Icons.menu_book_outlined,
                        color: Colors.orange,
                        onTap: () => context.push("/student/syllabus"),
                      ),

                      DashboardCard(
                        title: "Time Table",
                        icon: Icons.schedule_outlined,
                        color: Colors.red,
                        onTap: () => context.push("/student/timetable"),
                      ),
                      DashboardCard(
                        title: "Exams",
                        icon: Icons.library_books_outlined,
                        color: Colors.purple,
                        onTap: () => context.push("/student/exams"),
                      ),
                      DashboardCard(
                        title: "Results",
                        icon: Icons.assignment_turned_in_outlined,
                        color: Colors.indigo,
                        onTap: () => context.push("/student/results"),
                      ),

                      DashboardCard(
                        title: "Fees",
                        icon: Icons.payments_outlined,
                        color: Colors.brown,
                        onTap: () => context.push("/student/fees"),
                      ),
                      DashboardCard(
                        title: "Profile",
                        icon: Icons.person_outline,
                        color: Colors.teal,
                        onTap: () => context.push("/student/profile"),
                      ),
                      DashboardCard(
                        title: "Settings",
                        icon: Icons.settings_outlined,
                        color: Colors.grey,
                        onTap: () => context.push("/student/settings"),
                      ),
                    ]


                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: ThemeColors.primary,
              child: const Center(
                child: CustomText(
                  text: "Developed by Aamir Almani and Ahmed 🚀",

                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,

                ),
              ),
            ),

            // Add more rows if you want...
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
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


// Custom Clipper for curved background
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 50);
    p.quadraticBezierTo(
      size.width / 6,
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

