import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/screen/authentication_page.dart';
import 'package:new_travel_app/screen/login_screen.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _firstnameController = TextEditingController();
TextEditingController _lastnameController = TextEditingController();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
bool _isPasswordVisible = false;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  void _passwordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
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
                    "assets/image/background_image.jpg",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            const Positioned(
              left: 35,
              top: 130,
              child: Text(
                'Sign Up',
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
                top: 200,
                child: textfield(screenWidth, _firstnameController,
                    'First Name', 'Please enter the first name')),
            Positioned(
                left: screenWidth * .07,
                top: 280,
                child: textfield(screenWidth, _lastnameController, 'Last Name',
                    'Please enter the last name')),
            Positioned(
                left: screenWidth * .07,
                top: 360,
                child: textfield(screenWidth, _usernameController, 'Username',
                    'Please enter the username')),
            Positioned(
              left: screenWidth * .07,
              top: 440,
              child: SizedBox(
                width: screenWidth * 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _passwordVisibility,
                          icon: _isPasswordVisible
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black45,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(color: Colors.black45),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black
                              .withOpacity(0.3), // Set hint text color
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the password';
                        }

                        // Check if password is at least 8 characters long
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }

                        // Check if password contains at least one numeric number
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'must contain at least one numeric number';
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
                      }),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.1,
              bottom: 200,
              child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        // Check if the username already exists
                        bool usernameExists = await AuthenticationDb.singleton
                            .usernameExists(_usernameController.text);

                        if (usernameExists) {
                          // Username already exists, show an error SnackBar
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Username already exists. Please choose another username.'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          // Username doesn't exist, proceed with sign-up
                          final users = AuthenticationModels(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: _firstnameController.text +
                                _lastnameController.text,
                            password: _passwordController.text,
                            username: _usernameController.text,
                          );

                          AuthenticationDb.singleton.insertUsers(users);
                          // Clear the text fields
                          _firstnameController.text = '';
                          _lastnameController.text = '';
                          _usernameController.text = '';
                          _passwordController.text = '';

                          // Unfocus the text fields to hide the keyboard
                          // ignore: use_build_context_synchronously
                          FocusScope.of(context).unfocus();

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created successfully!'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          final sharedpref =
                              await SharedPreferences.getInstance();
                          sharedpref.setBool(saveKey, true);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNavigation(),
                              settings: RouteSettings(arguments: users.name),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: const Color(0xFF00CEC9),
                    ),
                    child: const Text(
                      'Submit',
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
                  "Already have an account?",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
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

  Widget textfield(double screenWidth, TextEditingController controller,
      String label, String message) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70, // Set the background color
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 2), // Offset in x and y axes
            ),
          ],
        ),
        child: TextFormField(
            controller: controller,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              label: Text(
                label,
                style: const TextStyle(color: Colors.black45),
              ),

              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.3), // Set hint text color
                // fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none, // Remove the default border
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return message;
              } else {
                return null;
              }
            }),
      ),
    );
  }
}
