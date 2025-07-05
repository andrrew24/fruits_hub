import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    required this.onSaved,
  });

  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?) onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      isObscured: _isObscured,
      hintText: widget.hintText,
      textInputType: widget.textInputType,
      onSaved: widget.onSaved,
      suffixIcon: GestureDetector(
        child: Icon(
          _isObscured ? Icons.visibility : Icons.visibility_off,
          color: const Color(0xFF949D9E),
        ),
        onTap: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      ),
    );
  }
}
