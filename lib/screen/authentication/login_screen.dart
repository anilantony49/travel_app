import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/destinations_screen.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/others/admin_credentials.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';
import 'package:new_travel_app/screen/authentication/sign_up_page.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:new_travel_app/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool isTyping = false;
  List<AuthenticationModels> items = [];

  final formKey = GlobalKey<FormState>();
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
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    "assets/image/background.jpg",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 60,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const Positioned(
              left: 35,
              top: 130,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none,
                  // letterSpacing: 1.5,
                ),
              ),
            ),
            Positioned(
              left: screenWidth * .07,
              top: 250,
              child: CustomInputField(
                  controller: _usernameController,
                  label: 'Username',
                  togglePasswordVisibility: null,
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
              top: 330,
              child: CustomInputField(
                isPassword: true,
                controller: _passwordController,
                label: 'Password',
                togglePasswordVisibility: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.password;
                  }

                  // Check if password is at least 8 characters long
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }

                  // Check if password contains at least one uppercase letter
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'must contain at least one uppercase letter';
                  }

                  // Check if password contains at least one lowercase letter
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return 'must contain at least one lowercase letter';
                  }

                  // Check if password contains at least one special character (e.g., '@')
                  if (!value.contains(RegExp(r'[@,!,#,$,^,%,&,*]'))) {
                    return 'must contain at least one special character (e.g., @)';
                  }

                  // If all conditions are met, return null (indicating a valid password)
                  return null;
                },
              ),
            ),
            Positioned(
              left: screenWidth * 0.1,
              bottom: 300,
              child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      // setState(() {
                      //   isTyping = false;
                      // });
                      if (_usernameController.text ==
                              AdminCredentials.username &&
                          _passwordController.text ==
                              AdminCredentials.password) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DestintationScreen(),
                          ), // Replace YourNextScreen with the actual screen widget you want to navigate to
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.welcomeAdmin),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                      if (formKey.currentState?.validate() ?? false) {
                        // Access the users list from the userNotifier value
                        List<AuthenticationModels> users =
                            AuthenticationDb.singleton.userNotifier.value;

                        // Replace 'enteredUsername' and 'enteredPassword' with the actual values entered by the user

                        String enteredUsername = _usernameController.text;
                        String enteredPassword = _passwordController.text;

                        // Check if entered username and password match any user details
                        bool isUserAuthenticated = users.any((user) =>
                            user.username == enteredUsername &&
                            user.password == enteredPassword);

                        // Clear the text fields
                        _usernameController.text = '';
                        _passwordController.text = '';
                        // Unfocus the text fields to hide the keyboard
                        FocusScope.of(context).unfocus();
                        if (isUserAuthenticated) {
                          final sharedpref =
                              await SharedPreferences.getInstance();
                          sharedpref.setBool(saveKey, true);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavigation(),
                              settings:
                                  RouteSettings(arguments: enteredUsername),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.loginSuccess),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.invalidError),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 8, backgroundColor: const Color(0xFF00CEC9)),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            const Positioned(
                left: 90,
                bottom: 270,
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                )),
            Positioned(
                right: 100,
                bottom: 270,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 14, color: Color(0xFF00CEC9)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
