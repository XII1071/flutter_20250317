import 'package:ch21_scheduler_token/const/colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText; // obscure 애매하게 하다
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const LoginTextField({
    required this.onSaved,
    required this.validator,
    this.obscureText = false,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      cursorColor: SECONDARY_COLOR,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: TEXT_FIELD_FILL_COLOR),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: SECONDARY_COLOR),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ERROR_COLOR),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ERROR_COLOR),
        ),
      ),
    );
  }
}
