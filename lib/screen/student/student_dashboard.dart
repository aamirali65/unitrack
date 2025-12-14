import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../utils/theme_colors.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool showNotifications = false;
  String userName = '';
  String userEmail = '';
  String studentId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await supabase
          .from('profiles')
          .select('full_name, email')
          .eq('id', user.id)
          .single();

      if (response != null && response is Map<String, dynamic>) {
        final email = response['email'] ?? user.email ?? '';
        setState(() {
          userName = response['full_name'] ?? '';
          userEmail = email;
          studentId = extractStudentId(email);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching profile: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  String extractStudentId(String email) {
    final regex = RegExp(r'\d+');
    final match = regex.firstMatch(email);
    if (match != null) {
      return match.group(0) ?? '';
    }
    return '';
  }


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
          text: "UniTrack University Portal",
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        leading: GestureDetector(
          onTap: () => context.push("/student/profile"),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showNotifications = !showNotifications;
                });
              },
              child: const Icon(Icons.notifications_none, size: 28, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.28,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: ThemeColors.primary,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, $userName",
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userEmail,
                          style: const TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                        Text(
                          "Student ID: $studentId",
                          style: const TextStyle(color: Colors.white70, fontSize: 15),
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
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
                          onTap: () => context.push("/settings"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (showNotifications)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => showNotifications = false),
                  child: Container(color: Colors.black12),
                ),
              ),

            if (showNotifications)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 260,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _notificationItem("Your midterm is tomorrow"),
                      _notificationItem("Assignment 2 uploaded"),
                      _notificationItem("Fee reminder, due next week"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.notifications, size: 20, color: ThemeColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 6,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
