import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/refracted_function/app_loginFunction.dart';
import 'package:new_travel_app/refracted_function/app_login_signup_ui.dart';
import 'package:new_travel_app/refracted_function/app_password_validator.dart';
import 'package:new_travel_app/screen/authentication/sign_up_page.dart';
import 'package:new_travel_app/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<AuthenticationModels> items = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  void fetchUsers() async {
    List<AuthenticationModels> fetchedItems =
        await AuthenticationDb.singleton.getUsers();
    setState(() {
      items = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            textWidget(
              context,
              AppStrings.loginBackgroundImage,
              'Login',
            ),
            Positioned(
              left: screenWidth * .07,
              top: screenWidth * .6,
              child: CustomInputField(
                  controller: _usernameController,
                  label: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.userename;
                    } else {
                      return null;
                    }
                  }),
            ),
            Positioned(
              left: screenWidth * .07,
              top: screenWidth * .8,
              child: CustomInputField(
                isPassword: true,
                controller: _passwordController,
                label: 'Password',
                validator: (value) {
                  return validatePassword(value!);
                },
              ),
            ),
            Positioned(
              left: screenWidth * 0.1,
              bottom: screenWidth * 0.5,
              child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      loginFunction(context, _usernameController,
                          _passwordController, formKey);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 8, backgroundColor: AppColors.greenColor),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            Positioned(
                left: screenWidth * 0.22,
                bottom: screenWidth * 0.4,
                child: Text(
                  AppStrings.createNewAccount,
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: AppColors.blackColor),
                )),
            Positioned(
                right: screenWidth * 0.27,
                bottom: screenWidth * 0.4,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: AppColors.greenColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
