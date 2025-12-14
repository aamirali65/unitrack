import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unitrack/widget/MyInputField.dart';
import 'package:unitrack/utils/theme_colors.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../widget/MyButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController enrollmentController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  String? enrollmentError;
  String? passwordError;
  String? fullNameError;
  String? roleError;

  String? selectedRole;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    enrollmentController.addListener(validateEnrollment);
    passwordController.addListener(validatePassword);
    fullNameController.addListener(validateFullName);
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

  void validateFullName() {
    final text = fullNameController.text.trim();
    String? error;

    if (text.isEmpty) {
      error = "Full name can't be empty";
    }

    if (error != fullNameError) {
      setState(() => fullNameError = error);
    }
  }

  void validateRole() {
    String? error;
    if (selectedRole == null) {
      error = "Please select a role";
    }
    if (error != roleError) {
      setState(() => roleError = error);
    }
  }

  @override
  void dispose() {
    enrollmentController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    validateEnrollment();
    validatePassword();
    validateFullName();
    validateRole();

    if (enrollmentError != null ||
        passwordError != null ||
        fullNameError != null ||
        roleError != null) {
      return;
    }

    setState(() => isLoading = true);

    final supabase = Supabase.instance.client;
    final enrollment = enrollmentController.text.trim();
    final password = passwordController.text;
    final fullName = fullNameController.text.trim();
    final role = selectedRole!;

    final email = 'user$enrollment@gmail.com';


    try {
      // Create user in Supabase Auth
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        throw Exception('Registration failed');
      }

      // Insert user profile with data
      await supabase.from('profiles').insert({
        'id': user.id,
        'email': email,
        'role': role,
        'full_name': fullName,
        'created_at': DateTime.now().toIso8601String(),
        'avatar_url': null,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Please login.')),
      );

      context.go('/login');

    } on AuthException catch (e) {
      print('AuthException during registration: ${e.message}');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e, stackTrace) {
      print('Exception during registration: $e');
      print(stackTrace);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }


  bool get isFormValid =>
      enrollmentError == null &&
          passwordError == null &&
          fullNameError == null &&
          roleError == null &&
          enrollmentController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          fullNameController.text.isNotEmpty &&
          selectedRole != null;

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
                            text: "UniTrack - Register New Account",
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
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Text(
                                enrollmentError!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),

                          const SizedBox(height: 16),

                          CustomInput(
                            controller: fullNameController,
                            hintText: 'Enter Full Name',
                            prefixIcon: Icons.person_outline,
                            borderColor:
                            fullNameError != null ? Colors.red : null,
                          ),
                          if (fullNameError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Text(
                                fullNameError!,
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
                              padding: const EdgeInsets.only(top: 4, left: 12),
                              child: Text(
                                passwordError!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),

                          const SizedBox(height: 16),

                          DropdownButtonFormField<String>(
                            value: selectedRole,
                            hint: Text('Select Role'),
                            items: ['student', 'teacher'].map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(
                                  role[0].toUpperCase() + role.substring(1),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedRole = val;
                                roleError = null;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              errorText: roleError,
                            ),
                          ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: isLoading ? 'Registering...' : 'Register',
                            onPressed: isFormValid && !isLoading
                                ? registerUser
                                : null,
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.go('/login');
                                },
                                child: Text(
                                  'Already have an account? Login',
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
