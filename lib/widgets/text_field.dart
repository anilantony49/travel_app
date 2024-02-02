import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool? isPassword;
  final bool? isPasswordVisible;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.isPasswordVisible = false,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.borderColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color:AppColors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          style: const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.isPassword!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility,
                            color: AppColors.blackColor)
                        : const Icon(Icons.visibility_off,
                            color: AppColors.blackColor),
                  )
                : null,
            label: Text(
              widget.label,
              style: const TextStyle(color: AppColors.blackColor),
            ),
            hintStyle: TextStyle(
              color: AppColors.black.withOpacity(0.3),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          obscureText: widget.isPassword! && !_isPasswordVisible,
          validator: widget.validator,
        ),
      ),
    );
  }
}
