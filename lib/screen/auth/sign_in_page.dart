import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:unitrack/widget/MyInputField.dart'; // your custom input
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

  @override
  void dispose() {
    enrollmentController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top image - no padding or margin
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset("assets/images/login.png", fit: BoxFit.cover),
            ),

            // Card below image with padding top, left, right
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
                          // Enrollment input
                          CustomInput(
                            controller: enrollmentController,
                            hintText: 'Enter Enrollment',
                            prefixIcon: Icons.person,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Password input
                          CustomInput(
                            controller: passwordController,
                            hintText: 'Enter Password',
                            prefixIcon: Icons.lock,
                            isPassword: true,
                          ),

                          const SizedBox(height: 24),

                          // Login button
                          CustomButton(
                            text: 'Login',
                            onPressed: () {
                              context.go('/student/dashboard');
                            },
                          ),

                          const SizedBox(height: 16),

                          // Forget password and Register options row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Navigate to register page
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const CustomText(
                                  text: 'Register New Account',

                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to forget password page
                                },
                                child: const CustomText(
                                  text: 'Forget Password?',

                                  fontSize: 14,
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
