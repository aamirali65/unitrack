import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../utils/theme_colors.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  bool showNotifications = false;
  String userName = '';
  String userEmail = '';
  String teacherId = '';
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
          teacherId = extractTeacherId(email);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching teacher profile: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  String extractTeacherId(String email) {
    // Assuming teacher ID is the numeric part inside email (e.g., teacher2412170@domain.com)
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
        actionsPadding: EdgeInsets.symmetric(vertical: 10),
        elevation: 0,
        title: const CustomText(
          textAlign: TextAlign.center,
          fontSize: 20,
          text: "UniTrack Teacher Portal",
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        leading: GestureDetector(
          onTap: () => context.push("/teacher/profile"),
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
            // MAIN UI START
            Column(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.28,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: ThemeColors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, Sir $userName",
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
                          "Teacher ID: T-$teacherId",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
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
                          title: "My Courses",
                          icon: Icons.book_outlined,
                          color: Colors.blue,
                          onTap: () => context.push("/teacher/course"),
                        ),
                        DashboardCard(
                          title: "Upload Lecture",
                          icon: Icons.upload_file_outlined,
                          color: Colors.green,
                          onTap: () => context.push("/teacher/lecture"),
                        ),
                        DashboardCard(
                          title: "Upload Assignment",
                          icon: Icons.assignment_outlined,
                          color: Colors.orange,
                          onTap: () => context.push("/teacher/assignment"),
                        ),
                        DashboardCard(
                          title: "Mark Attendance",
                          icon: Icons.check_circle_outline,
                          color: Colors.red,
                          onTap: () => context.push("/teacher/attendance"),
                        ),
                        DashboardCard(
                          title: "Time Table",
                          icon: Icons.schedule_outlined,
                          color: Colors.purple,
                          onTap: () => context.push("/teacher/timetable"),
                        ),
                        DashboardCard(
                          title: "Student List",
                          icon: Icons.group_outlined,
                          color: Colors.indigo,
                          onTap: () => context.push("/teacher/studentlist"),
                        ),
                        DashboardCard(
                          title: "Upload Results",
                          icon: Icons.assignment_turned_in_outlined,
                          color: Colors.brown,
                          onTap: () => context.push("/teacher/results"),
                        ),
                        DashboardCard(
                          title: "Profile",
                          icon: Icons.person_outline,
                          color: Colors.teal,
                          onTap: () => context.push("/teacher/profile"),
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

                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.symmetric(vertical: 5),
                //   color: ThemeColors.primary,
                //   child: const Center(
                //     child: CustomText(
                //       text: "Developed by Aamir Almani and Ahmed 🚀",
                //       color: Colors.white,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
            // MAIN UI END

            // NOTIFICATION BACKDROP
            if (showNotifications)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => showNotifications = false),
                  child: Container(color: Colors.black12),
                ),
              ),

            // NOTIFICATION PANEL
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
                      _notificationItem("3 students absent today"),
                      _notificationItem("New assignment submissions received"),
                      _notificationItem("Meeting scheduled at 4 PM"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Notification item
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


// Dashboard Card Component
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
        padding: const EdgeInsets.all(10),
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
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


// Curved Header
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 50);
    p.quadraticBezierTo(size.width / 6, size.height, size.width, size.height - 50);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
