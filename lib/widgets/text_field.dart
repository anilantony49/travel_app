import 'package:flutter/material.dart';
import 'package:new_travel_app/others/contants.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool isPasswordVisible;
  final Function()? togglePasswordVisibility;
  // final Function(String?) validator;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.togglePasswordVisibility,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
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
          controller: controller,
          style: const TextStyle(
            color: Constants.blackColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: togglePasswordVisibility,
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility,
                            color: Constants.blackColor)
                        : const Icon(Icons.visibility_off,
                            color: Constants.blackColor),
                  )
                : null,
            label: Text(
              label,
              style: const TextStyle(color: Constants.blackColor),
            ),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.3),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          obscureText: isPassword && !isPasswordVisible,
          validator: validator,
        ),
      ),
    );
  }
}
