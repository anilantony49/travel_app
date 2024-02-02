import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/refracted_function/app_login_signup_ui.dart';
import 'package:new_travel_app/refracted_function/app_password_validator.dart';
import 'package:new_travel_app/refracted_function/app_signupFunction.dart';
import 'package:new_travel_app/screen/authentication/login_screen.dart';
import 'package:new_travel_app/widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            textWidget(
              context,
              AppStrings.signUpBackgroundImage,
              'Sign Up',
            ),
            Positioned(
                left: screenWidth * .07,
                top: 280,
                child: CustomInputField(
                    controller: _usernameController,
                    label: 'Username',
                    validator: (value) {
                      if (value == null ||  value.trim().isEmpty) {
                        return AppStrings.userename;
                      } else {
                        return null;
                      }
                    })),
            Positioned(
                left: screenWidth * .07,
                top: 360,
                child: CustomInputField(
                    controller: _emailController,
                    label: 'email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.email;
                      } else if (!value.contains(AppStrings.gmailcom)) {
                        return AppStrings.enterValidEmail;
                      }
                      return null;
                    })),
            Positioned(
              left: screenWidth * .07,
              top: 440,
              child: CustomInputField(
                controller: _passwordController,
                label: 'Password',
                isPassword: true,
                validator: (value) {
                  return validatePassword(value!);
                },
              ),
            ),
            Positioned(
              left: screenWidth * 0.1,
              bottom: 200,
              child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      signUpFunction(context, _usernameController,
                          _emailController, _passwordController, _formKey);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: const Color(0xFF00CEC9),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
            ),
            const Positioned(
                left: 85,
                bottom: 180,
                child: Text(
                  AppStrings.alreadyHaveAccount,
                  style: TextStyle(fontSize: 14, color: AppColors.blackColor),
                )),
            Positioned(
                right: 100,
                bottom: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontSize: 14, color: Color(0xFF00CEC9)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
