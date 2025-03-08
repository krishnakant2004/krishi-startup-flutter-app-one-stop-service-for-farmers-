import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utility/app_data.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final double? height;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? lineNumber;
  final void Function(String?) onSave;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? labelColor;
  final Color? errorColor;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onSave,
    required this.controller,
    this.inputType = TextInputType.text,
    this.lineNumber = 1,
    this.validator,
    this.height,
    this.borderColor,
    this.focusedBorderColor,
    this.labelColor,
    this.errorColor,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        maxLines: lineNumber,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor ?? Colors.grey.shade600,
            fontSize: 16,
          ),
          floatingLabelStyle: TextStyle(
            color: focusedBorderColor ?? AppData.darkOrange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: focusedBorderColor ?? AppData.darkOrange,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: errorColor ?? Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: errorColor ?? Colors.red,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          errorStyle: TextStyle(
            color: errorColor ?? Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        keyboardType: inputType,
        onSaved: (value) {
          onSave(value?.isEmpty ?? true ? null : value);
        },
        validator: validator,
        inputFormatters: [
          LengthLimitingTextInputFormatter(700),
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
        ],
      ),
    );
  }
}