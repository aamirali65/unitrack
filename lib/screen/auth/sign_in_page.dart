import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unitrack/widget/MyInputField.dart';
import 'package:unitrack/utils/theme_colors.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../widget/MyButton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController enrollmentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? enrollmentError;
  String? passwordError;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    enrollmentController.addListener(validateEnrollment);
    passwordController.addListener(validatePassword);
  }

  void validateEnrollment() {
    final text = enrollmentController.text.trim();
    String? error;

    if (text.isEmpty) {
      error = "Enrollment can't be empty";
    } else if (!RegExp(r'^\d+$').hasMatch(text)) {
      error = "Enrollment must contain digits only";
    }

    if (error != enrollmentError) {
      setState(() => enrollmentError = error);
    }
  }

  void validatePassword() {
    final text = passwordController.text;
    String? error;

    if (text.isEmpty) {
      error = "Password can't be empty";
    } else if (text.length < 6) {
      error = "Password must be at least 6 characters";
    }

    if (error != passwordError) {
      setState(() => passwordError = error);
    }
  }

  @override
  void dispose() {
    enrollmentController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    validateEnrollment();
    validatePassword();

    if (enrollmentError != null || passwordError != null) return;

    setState(() => isLoading = true);

    final supabase = Supabase.instance.client;
    final enrollment = enrollmentController.text.trim();
    final password = passwordController.text;

    try {
      final email = 'user$enrollment@gmail.com';

      final authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null) {
        throw const AuthException('Login failed');
      }

      final profile = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

      print('Profile fetched: $profile');  // Debug print

      final role = profile['role'] as String?;

      if (!mounted) return;

      if (role == 'student') {
        context.go('/student/dashboard');
      } else if (role == 'teacher') {
        context.go('/teacher/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User role not assigned')),
        );
      }
    } on AuthException catch (e) {
      print('AuthException: ${e.message}');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e, stackTrace) {
      print('Exception during login: $e');
      print(stackTrace);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user profile')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }


  bool get isFormValid =>
      enrollmentError == null &&
          passwordError == null &&
          enrollmentController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset("assets/images/login.png", fit: BoxFit.cover),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomText(
                            text: "UniTrack - Portal App",
                            textAlign: TextAlign.center,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.primary,
                          ),
                          const SizedBox(height: 16),

                          CustomInput(
                            controller: enrollmentController,
                            hintText: 'Enter Enrollment',
                            prefixIcon: Icons.person_2_outlined,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            borderColor:
                            enrollmentError != null ? Colors.red : null,
                          ),
                          if (enrollmentError != null)
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 4, left: 12),
                              child: Text(
                                enrollmentError!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),

                          const SizedBox(height: 16),

                          CustomInput(
                            controller: passwordController,
                            hintText: 'Enter Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            borderColor:
                            passwordError != null ? Colors.red : null,
                          ),
                          if (passwordError != null)
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 4, left: 12),
                              child: Text(
                                passwordError!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: isLoading ? 'Logging in...' : 'Login',
                            onPressed: isFormValid && !isLoading
                                ? loginUser
                                : null,
                          ),

                          const SizedBox(height: 10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forget Password?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    color: ThemeColors.primary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/register');
                                },
                                child: Text(
                                  'Register New User?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    color: ThemeColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
