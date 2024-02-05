import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final AuthenticationModels? currentUser;

  const EditProfile({
    super.key,
    required this.currentUser,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

String selectedImagePath = '';

class _EditProfileState extends State<EditProfile> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    setState(() {
      selectedImagePath = image.path;
    });
  }

  @override
  void initState() {
    if (widget.currentUser != null) {
      selectedImagePath = widget.currentUser!.image ?? '';
      _usernameController.text = widget.currentUser!.username;
      _emailController.text = widget.currentUser!.email;
      _passwordController.text = widget.currentUser!.password;
    }

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwidget(
          title: AppStrings.editProfile, textStyle: GoogleFonts.alata()),
      body: BackgroundColor(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 4,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    pickImage(context, ImageSource.gallery);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: selectedImagePath.isNotEmpty
                        ? FileImage(File(selectedImagePath))
                        : const AssetImage(AppStrings.blankProfileImage)
                            as ImageProvider<Object>,
                    radius: 90,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: _usernameController,
                label: 'Username',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.enterUserName;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: _emailController,
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.enterEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: _passwordController,
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.enterPassword;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final editUser = AuthenticationModels(
                        id: widget.currentUser!.id,
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        image: selectedImagePath,
                      );
                      final sharedpref = await SharedPreferences.getInstance();
                      sharedpref.setString(
                          'edited_user_name', _usernameController.text);

                      if (selectedImagePath.isEmpty) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.selectImage),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      await AuthenticationDb.singleton
                          .editUsers(editUser, editUser.id);

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(AppStrings.editMessage),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop(true);

                      _emailController.clear();
                      _passwordController.clear();
                      _usernameController.clear();

                      // ignore: use_build_context_synchronously
                      FocusScope.of(context).unfocus();
                    } // ignore: use_build_context_synchronously
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 8, backgroundColor: AppColors.greenColor),
                  child: const Text(
                    AppStrings.saveChanges,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
