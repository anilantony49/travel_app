import 'package:new_travel_app/refracted_widgets/app_string.dart';

String? validatePassword(String value) {
  if (value.isEmpty) {
    return AppStrings.password;
  }
  // Check if password is at least 8 characters long
  if (value.length < 8) {
    return AppStrings.atleastEightCharecterErrorMsg;
  }
  // Check if password contains at least one numeric number
  if (!value.contains(RegExp(r'[0-9]'))) {
    return AppStrings.containOneNumberErrorMsg;
  }
  // Check if password contains at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return AppStrings.oneUppercaseLetterErrorMsg;
  }
  // Check if password contains at least one lowercase letter
  if (!value.contains(RegExp(r'[a-z]'))) {
    return AppStrings.oneLowercaseLetterErrorMsg;
  }
  // Check if password contains at least one special character (e.g., '@')
  if (!value.contains(RegExp(r'[@,!,#,$,^,%,&,*]'))) {
    return AppStrings.containeOneSpecialCharecterErrorMsg;
  }
  // If all conditions are met, return null (indicating a valid password)
  return null;
}
